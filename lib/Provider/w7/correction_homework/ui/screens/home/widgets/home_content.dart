import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/home_view_model.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    HomeViewModel mv = context.watch<HomeViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(mv.viewTitle, style: AppTextStyles.heading),
            SizedBox(height: 50),
 
            Card(
              color: Colors.grey[200] ,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ExpansionTile(
                shape: Border(),
                title: Text("My favorite songs", style: AppTextStyles.title),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: mv.favoriteSongs.length,
                    itemBuilder: (context, index) => SongTile(
                      song: mv.favoriteSongs[index],
                      isPlaying: mv.isSongPlaying(mv.favoriteSongs[index]),
                      onTap: () {
                        mv.start(mv.favoriteSongs[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
 
            SizedBox(height: 20),
 
            Card(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ExpansionTile(
                shape: Border(),
                title: Text("My last songs", style: AppTextStyles.title),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: mv.lastPlayedSongs.length,
                    itemBuilder: (context, index) => SongTile(
                      song: mv.lastPlayedSongs[index],
                      isPlaying: mv.isSongPlaying(mv.lastPlayedSongs[index]),
                      onTap: () {
                        mv.start(mv.lastPlayedSongs[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
 
          ],
        ),
      ),
    );
  }
}
