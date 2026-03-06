// song_repository_remote.dart
 
import '../../../model/songs/song.dart';
import 'song_repository.dart';

class SongRepositoryRemote implements SongRepository {
  @override
  Future<List<Song>>  fetchSongs() async {
    return [
      Song(
        id: '1',
        title: 'Remote Song 1',
        artist: 'Artist A',
        duration: const Duration(minutes: 3, seconds: 45),
      ),
      Song(
        id: '2',
        title: 'Remote Song 2',
        artist: 'Artist B',
        duration: const Duration(minutes: 4, seconds: 10),
      ),
    ];
  }

  @override
  Future<Song?> fetchSongById(String id) async{
    final songs =  await fetchSongs();
    return songs.firstWhere((song) => song.id == id);
  }
}
