import 'package:classwork/Provider/w7/small_homework/data/repositories/songs/song_repository.dart';
import 'package:classwork/Provider/w7/small_homework/model/songs/song.dart';
import 'package:classwork/Provider/w7/small_homework/ui/states/player_state.dart';
import 'package:flutter/material.dart';



class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  LibraryViewModel({required this.songRepository, required this.playerState});

  List<Song> _songs = [];

  List<Song> get songs => _songs;
  Song? get playingSong => playerState.currentSong;

  Future<void> init() async {
    _songs = songRepository.fetchSongs();

    playerState.addListener(() {
      notifyListeners();
    });

    notifyListeners();
  }

  void play(Song song) {
    playerState.start(song);
  }

  void stop() {
    playerState.stop();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }
}



