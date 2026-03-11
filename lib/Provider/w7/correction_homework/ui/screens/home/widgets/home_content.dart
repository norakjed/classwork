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


            ListCard(cardTitle:"Favorites song", listSongs: mv.favoriteSongs, mv: mv),

            SizedBox(height: 20),

            ListCard(cardTitle:"Last play song", listSongs: mv.lastPlayedSongs, mv: mv),
          ],
        ),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  const ListCard({super.key, required this.mv, required this.cardTitle, required this.listSongs});

  final HomeViewModel mv;
  final String cardTitle;
  final List listSongs;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        shape: Border(),
        title: Text(cardTitle),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listSongs.length,
            itemBuilder: (context, index) => SongTile(
              song: listSongs[index],
              isPlaying: mv.isSongPlaying(listSongs[index]),
              onTap: () {
                mv.start(listSongs[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
