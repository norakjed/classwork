import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

enum LibraryStatus { loading, success, error }

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  List<Song>? _songs;
  LibraryStatus _status = LibraryStatus.loading;
  String? _errorMessage;

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  List<Song> get songs => _songs == null ? [] : _songs!;
  LibraryStatus get status => _status;
  String? get errorMessage => _errorMessage;

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    _status = LibraryStatus.loading;
    notifyListeners();

    try {
      _songs = await songRepository.fetchSongs();
      _status = LibraryStatus.success;
    } catch (e) {
      _status = LibraryStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
