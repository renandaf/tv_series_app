import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/pages/search_movie_page.dart';
import 'package:movies/presentation/provider/popular_movies_notifier.dart';
import 'package:movies/presentation/widgets/card_movie_list.dart';
import 'package:provider/provider.dart';

class PopularMoviePage extends StatefulWidget {
  static const routeName = '/popular_movie';

  const PopularMoviePage({super.key});

  @override
  State<PopularMoviePage> createState() => _PopularMoviePageState();
}

class _PopularMoviePageState extends State<PopularMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularMoviesNotifier>(context, listen: false)
            .fetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SafeArea(child: CustomDrawer()),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Popular Movies',
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
          child: Consumer<PopularMoviesNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == RequestState.loaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = data.movies[index];
                    return MovieList(movie);
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
