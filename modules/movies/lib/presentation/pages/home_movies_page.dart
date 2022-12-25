import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/widgets/card_movie.dart';

class HomePageMovies extends StatefulWidget {
  static const routeName = '/homeMovie';

  const HomePageMovies({super.key});

  @override
  State<HomePageMovies> createState() => _HomePageMoviesState();
}

class _HomePageMoviesState extends State<HomePageMovies> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMovieBloc>().add(OnNowPlayingMovie());
      context.read<PopularMovieBloc>().add(OnPopularMovie());
      context.read<TopRatedMovieBloc>().add(OnTopRatedMovie());
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
          'Movies',
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
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular',
                style: kH6,
              ),
              SizedBox(
                height: 240,
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<PopularMovieBloc, MovieState>(
                          builder: (context, state) {
                        if (state is MovieLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is MovieListHasData) {
                          return PageView.builder(
                              itemCount: 8,
                              pageSnapping: true,
                              itemBuilder: (context, pagePosition) {
                                return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          DetailMoviePage.routeName,
                                          arguments:
                                              state.result[pagePosition].id,
                                        );
                                      },
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              GetMovieDetail.backDropImage(state
                                                  .result[pagePosition]
                                                  .backdropPath!)),
                                    ));
                              });
                        } else {
                          return Center(
                            child: Text(
                              'Failed to Get Data',
                              style: kH6,
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _buildSubHeading(
                  title: 'Now Playing',
                  onTap: () {
                    Navigator.pushNamed(context, NowPlayingMoviePage.routeName);
                  }),
              SizedBox(
                height: 240,
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<NowPlayingMovieBloc, MovieState>(
                          builder: (context, state) {
                        if (state is MovieLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is MovieListHasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.result.length,
                            itemBuilder: (BuildContext context, int index) {
                              Movie movie = state.result[index];
                              return CardMovie(movie);
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
                      }),
                    ),
                  ],
                ),
              ),
              _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () {
                    Navigator.pushNamed(context, TopRatedMoviePage.routeName);
                  }),
              SizedBox(
                height: 240,
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<TopRatedMovieBloc, MovieState>(
                          builder: (context, state) {
                        if (state is MovieLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is MovieListHasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.result.length,
                            itemBuilder: (BuildContext context, int index) {
                              Movie movie = state.result[index];
                              return CardMovie(movie);
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
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kH6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'See More',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
