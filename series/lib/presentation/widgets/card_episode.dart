import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:series/domain/entities/episode.dart';

class EpisodeList extends StatelessWidget {
  final Episode episode;
  const EpisodeList(this.episode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: kYellow, width: 1)),
          child: Image.asset(
            "assets/video.png",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Episode ${episode.episodeNumber}",
            style: kH5,
          ),
          Text(
            episode.name,
            style: kH6,
          ),
        ])
      ]),
    );
  }
}
