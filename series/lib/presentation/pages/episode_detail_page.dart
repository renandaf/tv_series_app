import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/widgets/card_episode.dart';
import 'package:series/series.dart';

class SeasonPage extends StatefulWidget {
  final int id;
  final int seasonNumber;
  const SeasonPage({super.key, required this.id, required this.seasonNumber});
  static const routeName = '/season_detail';

  @override
  State<SeasonPage> createState() => _SeasonPageState();
}

class _SeasonPageState extends State<SeasonPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<SeasonDetailNotifier>(context, listen: false)
            .fetchSeason(widget.id, widget.seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Season ${widget.seasonNumber}',
          style: kH3,
        ),
      ),
      body: Consumer<SeasonDetailNotifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.state == RequestState.loaded) {
            return ListView.builder(
              itemCount: data.season.episodes.length,
              itemBuilder: (BuildContext context, int index) {
                var episode = data.season.episodes[index];
                return EpisodeList(episode);
              },
            );
          } else {
            return Center(
                child: Text(
              data.message,
              style: kH6,
            ));
          }
        },
      ),
    );
  }
}
