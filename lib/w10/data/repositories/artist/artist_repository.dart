import 'package:classwork/w10/model/comment/comment.dart';
import 'package:classwork/w10/model/songs/song.dart';

import '../../../model/artist/artist.dart';
 

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists({bool forceFetch = false});
  
  Future<Artist?> fetchArtistById(String id);

  Future<List<Song>> fetchSongsByArtist(String artistId);

  Future<List<Comment>> fetchCommentsByArtist(String artistId);

  Future<Comment> postComment(String artistId, String text);
}
