import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/user/user_repository.dart';
import 'view_model/home_view_model.dart';
import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import 'widgets/home_content.dart';
 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        userRepository: context.read<UserRepository>(),
        playerState: context.read<PlayerState>(),
        songRepository: context.read<SongRepository>(),
      ),
      child: HomeContent(),
    );
  }
}
