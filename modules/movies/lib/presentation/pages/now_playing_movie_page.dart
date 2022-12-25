import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/pages/search_movie_page.dart';
import 'package:movies/presentation/provider/now_playing_movie_notifier.dart';
import 'package:movies/presentation/widgets/card_movie_list.dart';
import 'package:provider/provider.dart';

class NowPlayingMoviePage extends StatefulWidget {
  static const routeName = '/now_playing_movie';

  const NowPlayingMoviePage({super.key});

  @override
  State<NowPlayingMoviePage> createState() => _NowPlayingMoviePageState();
}

class _NowPlayingMoviePageState extends State<NowPlayingMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayingMovieNotifier>(context, listen: false)
            .fetchNowPlayingMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Now Playing Movies',
            style: kH3,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchMoviePage.routeName);
              },
              icon: const Icon(
                Icons.search,
                size: 32,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Consumer<NowPlayingMovieNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == RequestState.loaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = data.movie[index];
                    return MovieList(movie, index);
                  },
                  itemCount: data.movie.length,
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
        ));
  }
}
