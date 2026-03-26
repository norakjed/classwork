import 'package:classwork/w9_firebase/data/dtos/song_dto.dart';
import 'package:flutter/material.dart';

import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.artist,
    required this.genre,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final String artist;
  final String genre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(song.imageUrl.toString()),
          ),
          subtitle: Row(
            children: [
              Text("${song.duration.inMinutes} mn"),
              const SizedBox(width: 10),
              Text("$artist - $genre"),
            ],
          ),
          onTap: onTap,
          title: Text(song.title),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
