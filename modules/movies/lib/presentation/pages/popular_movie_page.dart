import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/widgets/card_movie_list.dart';

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
    Future.microtask(() {
      context.read<PopularMovieBloc>().add(OnPopularMovie());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
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
          child: BlocBuilder<PopularMovieBloc, MovieState>(
              builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieListHasData) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (BuildContext context, int index) {
                  Movie movie = state.result[index];
                  return MovieList(movie, index);
                },
              );
            } else {
              return Center(
                child: Text('Failed to Get Data',
                    style: kH6, key: const Key("error")),
              );
            }
          }),
        ));
  }
}
