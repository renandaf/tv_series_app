import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/pages/now_playing_movie_page.dart';
import 'package:movies/presentation/pages/top_rated_movie_page.dart';
import 'package:movies/presentation/provider/movie_list_notifier.dart';
import 'package:movies/presentation/widgets/card_movie.dart';
import 'package:provider/provider.dart';
import 'package:series/series.dart';

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
    Future.microtask(() =>
        Provider.of<MovieListNotifier>(context, listen: false)
            .fetchTopRatedMovies());
    Future.microtask(() =>
        Provider.of<MovieListNotifier>(context, listen: false)
            .fetchNowPlayingMovies());
    Future.microtask(() =>
        Provider.of<MovieListNotifier>(context, listen: false)
            .fetchPopularMovies());
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
              Navigator.pushNamed(context, SearchPage.routeName);
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
                      child: Consumer<MovieListNotifier>(
                        builder: (context, data, child) {
                          if (data.popularMoviesState == RequestState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.popularMoviesState ==
                              RequestState.loaded) {
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
                                            DetailPage.routeName,
                                            arguments: data
                                                .popularMovies[pagePosition].id,
                                          );
                                        },
                                        child: CachedNetworkImage(
                                            imageUrl: GetSeriesDetail
                                                .backDropImage(data
                                                    .popularMovies[pagePosition]
                                                    .backdropPath!)),
                                      ));
                                });
                          } else {
                            return Center(
                                child: Text(
                              data.message,
                              style: kH6,
                            ));
                          }
                        },
                      ),
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
                      child: Consumer<MovieListNotifier>(
                        builder: (context, data, child) {
                          if (data.nowPlayingState == RequestState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.nowPlayingState ==
                              RequestState.loaded) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final movie = data.nowPlayingMovies[index];
                                return CardMovie(movie);
                              },
                              itemCount: 5,
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
                      child: Consumer<MovieListNotifier>(
                        builder: (context, data, child) {
                          if (data.topRatedMoviesState ==
                              RequestState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.topRatedMoviesState ==
                              RequestState.loaded) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final movie = data.topRatedMovies[index];
                                return CardMovie(movie);
                              },
                              itemCount: 5,
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
