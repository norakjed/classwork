import 'package:classwork/Provider/w7/small_homework/ui/screens/library/view_model/library_view_model.dart';
import 'package:classwork/Provider/w7/small_homework/ui/screens/library/widgets/library_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';


class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LibraryViewModel(
        songRepository: context.read<SongRepository>(),
        playerState: context.read<PlayerState>(),
      )..init(),
      child: const LibraryContent(),
    );
  }
}
