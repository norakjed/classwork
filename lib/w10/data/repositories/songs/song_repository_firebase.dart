import 'dart:convert';

import 'package:classwork/w10/config/firebase_config.dart';
import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = FirebaseConfig.baseUri.replace(path: '/songs.json');

  List<Song>? _cachedSongs;

  @override
  Future<List<Song>> fetchSongs({bool forceFetch = false}) async {
    // 1. Return cache if available and not forced
    if (_cachedSongs != null && !forceFetch) {
      return _cachedSongs!;
    }

    // 2. Otherwise fetch from API
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in artistJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }

      // 3. Store in cache
      _cachedSongs = result;

      return _cachedSongs!;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<void> likeSong(String songId, int currentLikes) async {
    final Uri songLikeUri = FirebaseConfig.baseUri.replace(
      path: '/songs/$songId.json',
    );

    final http.Response response = await http.patch(
      songLikeUri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'likes': currentLikes + 1}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to like song $songId');
    }
  }
}
