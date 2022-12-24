import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/presentation/widgets/card_movie.dart';
import 'package:provider/provider.dart';

import '../provider/movie_detail_notifier.dart';

class DetailMoviePage extends StatefulWidget {
  final int id;
  const DetailMoviePage({super.key, required this.id});
  static const routeName = '/detail_movie';

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MovieDetailNotifier>(context, listen: false)
            .fetchMovieDetail(widget.id));
    Future.microtask(() =>
        Provider.of<MovieDetailNotifier>(context, listen: false)
            .loadWatchlistStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<MovieDetailNotifier>(
        builder: (context, data, child) {
          if (data.movieState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.movieState == RequestState.loaded) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.45,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              GetMovieDetail.posterImage(
                                  data.movie.posterPath!)),
                          fit: BoxFit.cover),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: kRichBlack,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: kYellow,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (data.movie.overview!.length > 270) ? 1100 : 900,
                    child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 0.06],
                            colors: [Colors.transparent, Colors.black],
                          ),
                        ),
                        margin: EdgeInsets.only(top: size.height * 0.38),
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: [
                                  Text(
                                    data.movie.title!,
                                    style: kTitle,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          data.movie.releaseDate
                                              .toString()
                                              .substring(0, 4),
                                          style: kSmall,
                                        ),
                                        Text(
                                          " | ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              letterSpacing: 0.25,
                                              color:
                                                  kDavysGrey.withOpacity(0.5)),
                                        ),
                                        data.movie.genres!.length > 2
                                            ? Text(
                                                "${data.movie.genres![0].name}, ${data.movie.genres![1].name}",
                                                style: kSmall,
                                              )
                                            : Text(
                                                data.movie.genres![0].name,
                                                style: kSmall,
                                              ),
                                        Text(
                                          " | ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              letterSpacing: 0.25,
                                              color:
                                                  kDavysGrey.withOpacity(0.5)),
                                        ),
                                        Text(
                                          "${data.movie.runtime} minutes",
                                          style: kSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  RatingBarIndicator(
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    rating: 4.3,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: kYellow,
                                    ),
                                    itemSize: 25,
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Consumer<MovieDetailNotifier>(
                                      builder: (context, provider, child) {
                                    return ElevatedButton(
                                        onPressed: () async {
                                          if (!provider.isAddedToWatchlist) {
                                            await Provider.of<
                                                        MovieDetailNotifier>(
                                                    context,
                                                    listen: false)
                                                .addWatchlist(data.movie);
                                          } else {
                                            await Provider.of<
                                                        MovieDetailNotifier>(
                                                    context,
                                                    listen: false)
                                                .removeFromWatchlist(
                                                    data.movie);
                                          }
                                        },
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsets>(
                                                const EdgeInsets.symmetric(
                                                    vertical: 13,
                                                    horizontal: 43)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ))),
                                        child: Text(
                                          provider.isAddedToWatchlist
                                              ? "Remove from Watchlist"
                                              : "Add to Watchlist",
                                          style: const TextStyle(fontSize: 18),
                                        ));
                                  }),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Divider(
                                    indent: 30,
                                    endIndent: 30,
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Overview",
                                        style: kH6,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          data.movie.overview!.length < 2
                                              ? "No Overview"
                                              : data.movie.overview!,
                                          style: kBody),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ]),
                              ),
                              Divider(
                                indent: 30,
                                endIndent: 30,
                                color: Colors.white.withOpacity(0.2),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  "Recommendations",
                                  style: kH6,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Consumer<MovieDetailNotifier>(
                                    builder: (context, data, child) {
                                      if (data.recommendationState ==
                                          RequestState.loading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (data.recommendationState ==
                                          RequestState.loaded) {
                                        if (data.movieRecommendations.isEmpty) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "-",
                                              style: kH6,
                                            ),
                                          );
                                        } else {
                                          return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final movie = data
                                                  .movieRecommendations[index];
                                              return CardMovie(movie);
                                            },
                                            itemCount: 5,
                                          );
                                        }
                                      } else {
                                        return Center(
                                            child: Text(
                                          data.message,
                                          style: kBody,
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ])),
                  ),
                ],
              ),
            );
          } else {
            return Center(
                child: Text(
              data.message,
              style: kBody,
            ));
          }
        },
      ),
    );
  }
}
