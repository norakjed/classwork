import 'package:classwork/Provider/w7/small_homework/data/repositories/songs/song_repository.dart';
import 'package:classwork/Provider/w7/small_homework/data/repositories/users/user_history_repository.dart';
import 'package:classwork/Provider/w7/small_homework/model/songs/song.dart';
import 'package:classwork/Provider/w7/small_homework/ui/states/player_state.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final UserHistoryRepository historyRepository;
  final PlayerState playerState;

  HomeViewModel({
    required this.songRepository,
    required this.historyRepository,
    required this.playerState,
  });

  List<Song> _songs = [];
  List<Song> _recentSongs = [];
  List<Song> _recommendedSongs = [];

  List<Song> get songs => _songs;
  List<Song> get recentSongs => _recentSongs;
  List<Song> get recommendedSongs => _recommendedSongs;
  Song? get playingSong => playerState.currentSong;

  Future<void> init() async {
    _songs = songRepository.fetchSongs();

    _loadRecentSongs();
    _generateRecommendations();

    playerState.addListener(() {
      notifyListeners();
    });

    notifyListeners();
  }

  void _loadRecentSongs() {
    final ids = historyRepository.getRecentSongIds();

    _recentSongs = _songs.where((song) => ids.contains(song.id)).toList();
  }

  void _generateRecommendations() {
    _recommendedSongs = _songs
        .where((song) => !_recentSongs.contains(song))
        .take(3)
        .toList();
  }

  void play(Song song) {
    playerState.start(song);
    notifyListeners();
  }

  void stop() {
    playerState.stop();
  }
}
