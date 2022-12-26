import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:series/presentation/widgets/card_series.dart';
import 'package:series/series.dart';

class DetailPage extends StatefulWidget {
  final int id;
  const DetailPage({super.key, required this.id});
  static const routeName = '/detail_series';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeriesDetailBloc>().add(OnDetailSeries(widget.id));
      context
          .read<SeriesRecommendationBloc>()
          .add(OnSeriesRecommendation(widget.id));
      context
          .read<SeriesWatchlistBloc>()
          .add(OnSeriesWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<SeriesDetailBloc, SeriesState>(
        builder: (context, state) {
          if (state is SeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailHasData) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        GetSeriesDetail.posterImage(state.result.posterPath!),
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
                    height: (state.result.overview!.length > 290) ? 1200 : 1000,
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
                                  Center(
                                    child: Text(
                                      state.result.name!,
                                      style: kTitle,
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.result.firstAirDate
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
                                          "${state.result.numberOfEpisodes} Episodes",
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
                                  BlocBuilder<SeriesWatchlistBloc, SeriesState>(
                                      builder: (context, result) {
                                    if (result is SeriesWatchlistStatus) {
                                      return ElevatedButton(
                                          onPressed: () async {
                                            if (result.status == false) {
                                              context
                                                  .read<SeriesWatchlistBloc>()
                                                  .add(OnAddSeriesWatchlist(
                                                      state.result));
                                              BlocProvider.of<
                                                          SeriesWatchlistBloc>(
                                                      context)
                                                  .add(OnSeriesWatchlistStatus(
                                                      widget.id));
                                            } else {
                                              context
                                                  .read<SeriesWatchlistBloc>()
                                                  .add(OnRemoveSeriesWatchlist(
                                                      state.result));
                                              BlocProvider.of<
                                                          SeriesWatchlistBloc>(
                                                      context)
                                                  .add(OnSeriesWatchlistStatus(
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
                                          key: const Key("error"),
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
                                  "All Season",
                                  style: kH6,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.result.numberOfSeasons,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: InkWell(
                                          key: const Key("season"),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SeasonPage(
                                                    id: state.result.id!,
                                                    seasonNumber: (index + 1),
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: kYellow, width: 2)),
                                            width: 110,
                                            child: Center(
                                              child: Text(
                                                "Season ${index + 1}",
                                                style: kH6Yellow,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
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
                                  child: BlocBuilder<SeriesRecommendationBloc,
                                      SeriesState>(
                                    builder: (context, recom) {
                                      if (recom is SeriesLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (recom is SeriesListHasData) {
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
                                              final series =
                                                  recom.result[index];
                                              return CardSeries(series);
                                            },
                                            itemCount: 5,
                                          );
                                        }
                                      } else {
                                        return Center(
                                            child: Text(
                                          "Failed to Get Data",
                                          style: kBody,
                                          key: const Key("error"),
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
              key: const Key("error"),
            ));
          }
        },
      ),
    );
  }
}
