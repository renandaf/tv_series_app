import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/widgets/card_movie.dart';

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
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(OnDetailMovie(widget.id));
      context
          .read<MovieRecommendationBloc>()
          .add(OnMovieRecommendation(widget.id));
      context.read<MovieWatchlistBloc>().add(OnMovieWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        GetMovieDetail.posterImage(state.result.posterPath!),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.45,
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
                    height: (state.result.overview!.length > 270) ? 1100 : 900,
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
                                    state.result.title!,
                                    style: kTitle,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.result.releaseDate
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
                                        state.result.genres!.length > 2
                                            ? Text(
                                                "${state.result.genres![0].name}, ${state.result.genres![1].name}",
                                                style: kSmall,
                                              )
                                            : Text(
                                                state.result.genres![0].name,
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
                                          "${state.result.runtime} minutes",
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
                                  BlocBuilder<MovieWatchlistBloc, MovieState>(
                                      builder: (context, result) {
                                    if (result is MovieWatchlistStatus) {
                                      return ElevatedButton(
                                          onPressed: () async {
                                            if (result.status == false) {
                                              context
                                                  .read<MovieWatchlistBloc>()
                                                  .add(OnAddMovieWatchlist(
                                                      state.result));
                                              BlocProvider.of<
                                                          MovieWatchlistBloc>(
                                                      context)
                                                  .add(OnMovieWatchlistStatus(
                                                      widget.id));
                                            } else {
                                              context
                                                  .read<MovieWatchlistBloc>()
                                                  .add(OnRemoveMovieWatchlist(
                                                      state.result));
                                              BlocProvider.of<
                                                          MovieWatchlistBloc>(
                                                      context)
                                                  .add(OnMovieWatchlistStatus(
                                                      widget.id));
                                            }
                                          },
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 13,
                                                          horizontal: 43)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ))),
                                          child: Text(
                                            result.status
                                                ? "Remove from Watchlist"
                                                : "Add to Watchlist",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ));
                                    } else {
                                      return ElevatedButton(
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 13,
                                                          horizontal: 43)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ))),
                                          onPressed: () {},
                                          child: const Text(""));
                                    }
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
                                          state.result.overview!.length < 2
                                              ? "No Overview"
                                              : state.result.overview!,
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
                                  child: BlocBuilder<MovieRecommendationBloc,
                                      MovieState>(
                                    builder: (context, recom) {
                                      if (recom is MovieLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (recom is MovieListHasData) {
                                        if (recom.result.isEmpty) {
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
                                              final movie = recom.result[index];
                                              return CardMovie(movie);
                                            },
                                            itemCount: 5,
                                          );
                                        }
                                      } else {
                                        return Center(
                                            child: Text(
                                          "Failed to Get Data",
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
              "Failed to Get Data",
              style: kBody,
            ));
          }
        },
      ),
    );
  }
}
