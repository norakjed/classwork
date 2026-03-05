import 'package:classwork/Provider/w7/small_homework/data/repositories/users/user_history_repository.dart';
import 'package:classwork/Provider/w7/small_homework/data/repositories/users/user_history_repository_mock.dart';
import 'package:classwork/Provider/w7/small_homework/ui/screens/home/view_model/home_view_model.dart';
import 'package:classwork/Provider/w7/small_homework/ui/screens/home/widgets/home_content.dart';
import 'package:classwork/Provider/w7/small_homework/ui/states/player_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/songs/song_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        songRepository: context.read<SongRepository>(),
        historyRepository: UserHistoryRepositoryMock(),
        playerState: context.read<PlayerState>(),
      )..init(),
      child: const HomeContent(),
    );
  }
}
