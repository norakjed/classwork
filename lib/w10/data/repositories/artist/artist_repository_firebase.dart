import 'dart:convert';

import 'package:classwork/w10/config/firebase_config.dart';
import 'package:classwork/w10/data/dtos/comment_dto.dart';
import 'package:classwork/w10/data/dtos/song_dto.dart';
import 'package:classwork/w10/model/comment/comment.dart';
import 'package:classwork/w10/model/songs/song.dart';
import 'package:http/http.dart' as http;

import '../../../model/artist/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final Uri artistsUri = FirebaseConfig.baseUri.replace(path: '/artists.json');

  List<Artist>? _cachedArtists;

  // Fetch Artist
  @override
  Future<List<Artist>> fetchArtists({bool forceFetch = false}) async {
    // 1. Return cache if available and not forced
    if (_cachedArtists != null && !forceFetch) {
      return _cachedArtists!;
    }

    // 2. Otherwise fetch from API
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = json.decode(response.body);

      List<Artist> result = [];
      for (final entry in artistJson.entries) {
        result.add(ArtistDto.fromJson(entry.key, entry.value));
      }

      // 3.Store in cache
      _cachedArtists = result;

      return _cachedArtists!;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {}

  // Fetch song for artist
  @override
  Future<List<Song>> fetchSongsByArtist(String artistId) async {
    final Uri songsUri = FirebaseConfig.baseUri.replace(
      path: '/songs.json',
      queryParameters: {'orderBy': '"artistId"', 'equalTo': '"$artistId"'},
    );
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> songsJson = json.decode(response.body);

      return songsJson.entries
          .map((entry) => SongDto.fromJson(entry.key, entry.value))
          .toList();
    } else {
      throw Exception('Failed to load songs for artist $artistId');
    }
  }

  // Fetch comment for artist
  @override
  Future<List<Comment>> fetchCommentsByArtist(String artistId) async {
    final Uri commentsUri = FirebaseConfig.baseUri.replace(
      path: '/comments.json',
      queryParameters: {'orderBy': '"artistId"', 'equalTo': '"$artistId"'},
    );

    final http.Response response = await http.get(commentsUri);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      // Firebase returns null when no comments exist
      if (body == null) return [];

      final Map<String, dynamic> commentsJson = body;
      return commentsJson.entries
          .map((entry) => CommentDto.fromJson(entry.key, entry.value))
          .toList();
    } else {
      throw Exception('Failed to load comments for artist $artistId');
    }
  }

  // Post comment for artist
  @override
  Future<Comment> postComment(String artistId, String text) async {
    final Uri commentsUri = FirebaseConfig.baseUri.replace(
      path: '/comments.json',
    );

    final http.Response response = await http.post(
      commentsUri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(CommentDto.toJson(artistId, text)),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = json.decode(response.body);
      final String newId = responseJson['name'];

      return Comment(id: newId, artistId: artistId, text: text);
    } else {
      throw Exception('Failed to post comment for artist $artistId');
    }
  }
}
