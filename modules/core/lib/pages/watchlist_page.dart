import 'package:core/core.dart';
import 'package:core/widgets/watchlist_card.dart';
import 'package:core/widgets/watchlist_movie.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:series/series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieWatchlistBloc>().add(OnMovieWatchlist());
    });
    Future.microtask(() {
      context.read<SeriesWatchlistBloc>().add(OnSeriesWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<MovieWatchlistBloc>(context).add(OnMovieWatchlist());
    BlocProvider.of<SeriesWatchlistBloc>(context).add(OnSeriesWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Watchlist',
            style: kH3,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Movies",
                style: kH5,
              ),
            ),
            Expanded(
              child: BlocBuilder<MovieWatchlistBloc, MovieState>(
                  builder: (context, state) {
                if (state is WatchlistMovieHasData) {
                  if (state.result.isEmpty) {
                    return Center(child: Text("No data Found", style: kH5));
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = state.result[index];
                        return WatchListMovie(movie);
                      },
                      itemCount: state.result.length,
                    );
                  }
                } else {
                  return Center(
                    child: Text("No data Found",
                        style: kH6, key: const Key("error")),
                  );
                }
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "TV Series",
                style: kH5,
              ),
            ),
            Expanded(
              child: BlocBuilder<SeriesWatchlistBloc, SeriesState>(
                  builder: (context, state) {
                if (state is WatchlistSeriesHasData) {
                  if (state.result.isEmpty) {
                    return Center(child: Text("No data Found", style: kH5));
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final series = state.result[index];
                        return WatchList(series);
                      },
                      itemCount: state.result.length,
                    );
                  }
                } else {
                  return Center(
                    child: Text("No data Found",
                        style: kH6, key: const Key("error")),
                  );
                }
              }),
            ),
          ],
        ));
  }
}
