import 'package:classwork/Provider/w7/correction_homework/data/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/user/user.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

class HomeViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final SongRepository songRepository;
  final PlayerState playerState;

  List<Song>? _songs;
  User? _currentUser;

  HomeViewModel({
    required this.songRepository,
    required this.playerState,
    required this.userRepository,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  String get viewTitle =>
      "Welcome ${_currentUser != null ? _currentUser!.name : ""}";

  List<Song> get favoriteSongs {
    if (_songs == null || _currentUser == null) return [];

    return _songs!
        .where((song) => _currentUser!.favoriteSongs.contains(song.id))
        .toList();
  }

  List<Song> get lastPlayedSongs => _songs == null ? [] : _songs!;

  @override
  void dispose() {
    super.dispose();
    playerState.removeListener(notifyListeners);
  }

  void _init() async {
    // 1 - Fetch songs
    _songs = await songRepository.fetchSongs();

    // 2 - Fetch songs
    _currentUser = await userRepository.getUser();

    // 3 - notify listeners
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
