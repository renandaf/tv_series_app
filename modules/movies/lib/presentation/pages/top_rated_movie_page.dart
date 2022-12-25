import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/pages/search_movie_page.dart';
import 'package:movies/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movies/presentation/widgets/card_movie_list.dart';
import 'package:provider/provider.dart';

class TopRatedMoviePage extends StatefulWidget {
  static const routeName = '/top_rated_movie';

  const TopRatedMoviePage({super.key});

  @override
  State<TopRatedMoviePage> createState() => _TopRatedMoviePageState();
}

class _TopRatedMoviePageState extends State<TopRatedMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedMoviesNotifier>(context, listen: false)
            .fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Top Rated Movies',
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
          child: Consumer<TopRatedMoviesNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == RequestState.loaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = data.movies[index];
                    return MovieList(movie, index);
                  },
                  itemCount: data.movies.length,
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
