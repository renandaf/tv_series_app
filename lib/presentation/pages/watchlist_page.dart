import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/common/constants.dart';
import 'package:tv_series_app/common/utils.dart';
import 'package:tv_series_app/presentation/provider/watchlist_movie_notifier.dart';
import 'package:tv_series_app/presentation/provider/watchlist_provider.dart';
import 'package:tv_series_app/presentation/widgets/drawer.dart';
import 'package:tv_series_app/presentation/widgets/watchlist_card.dart';
import 'package:tv_series_app/presentation/widgets/watchlist_movie.dart';

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
    Future.microtask(() =>
        Provider.of<WatchListNotifier>(context, listen: false)
            .fetchWatchlistSeries());
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchListNotifier>(context, listen: false)
        .fetchWatchlistSeries();
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SafeArea(child: CustomDrawer()),
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
              child: Consumer<WatchlistMovieNotifier>(
                builder: (context, data, child) {
                  if (data.watchlistMovies.isEmpty) {
                    return Center(child: Text("No data Found", style: kH5));
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = data.watchlistMovies[index];
                        return WatchListMovie(movie);
                      },
                      itemCount: data.watchlistMovies.length,
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "TV Series",
                style: kH5,
              ),
            ),
            Expanded(
              child: Consumer<WatchListNotifier>(
                builder: (context, data, child) {
                  if (data.watchlistSeries.isEmpty) {
                    return Center(child: Text("No data Found", style: kH5));
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final series = data.watchlistSeries[index];
                        return WatchList(series);
                      },
                      itemCount: data.watchlistSeries.length,
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
