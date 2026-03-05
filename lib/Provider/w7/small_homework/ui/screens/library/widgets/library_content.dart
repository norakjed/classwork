import 'package:classwork/Provider/w7/small_homework/model/songs/song.dart';
import 'package:classwork/Provider/w7/small_homework/ui/screens/library/view_model/library_view_model.dart';
import 'package:classwork/Provider/w7/small_homework/ui/states/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LibraryViewModel>();

    return Container(
      color: context.watch<AppSettingsState>().theme.backgroundColor,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: vm.songs.length,
              itemBuilder: (context, index) {
                final song = vm.songs[index];

                return SongTile(
                  song: song,
                  isPlaying: vm.playingSong == song,
                  onTap: () => vm.play(song),
                  onStop: () => vm.stop(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onStop,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: Text(
        isPlaying ? "Playing" : "",
        style: TextStyle(color: Colors.amber),
      ),
    );
  }
}
