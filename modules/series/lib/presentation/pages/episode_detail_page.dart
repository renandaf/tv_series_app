import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/bloc/series_bloc.dart';
import 'package:series/presentation/widgets/card_episode.dart';

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
    Future.microtask(() {
      context
          .read<SeasonDetailBloc>()
          .add(OnSeasonDetail(widget.id, widget.seasonNumber));
    });
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
      body: BlocBuilder<SeasonDetailBloc, SeriesState>(
        builder: (context, state) {
          if (state is SeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeasonHasData) {
            return ListView.builder(
              itemCount: state.result.episodes.length,
              itemBuilder: (BuildContext context, int index) {
                var episode = state.result.episodes[index];
                return EpisodeList(episode);
              },
            );
          } else {
            return Center(
              child: Text(
                'Failed to Get Data',
                style: kH6,
              ),
            );
          }
        },
      ),
    );
  }
}
