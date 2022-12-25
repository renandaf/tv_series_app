import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
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
    Future.microtask(() =>
        Provider.of<DetailSeriesNotifier>(context, listen: false)
            .fetchDetailSeries(widget.id));
    Future.microtask(() =>
        Provider.of<WatchListNotifier>(context, listen: false)
            .loadWatchlistStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<DetailSeriesNotifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.state == RequestState.loaded) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        GetSeriesDetail.posterImage(data.series.posterPath!),
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
                    height: (data.series.overview!.length > 290) ? 1200 : 1000,
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
                                      data.series.name!,
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
                                          data.series.firstAirDate
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
                                        data.series.genres!.length > 2
                                            ? Text(
                                                "${data.series.genres![0].name}, ${data.series.genres![1].name}",
                                                style: kSmall,
                                              )
                                            : Text(
                                                data.series.genres![0].name,
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
                                          "${data.series.numberOfEpisodes} Episodes",
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
                                  Consumer<WatchListNotifier>(
                                      builder: (context, provider, child) {
                                    return ElevatedButton(
                                        onPressed: () async {
                                          if (!provider.isAddedToWatchlist) {
                                            await Provider.of<
                                                        WatchListNotifier>(
                                                    context,
                                                    listen: false)
                                                .addWatchlist(data.series);
                                          } else {
                                            await Provider.of<
                                                        WatchListNotifier>(
                                                    context,
                                                    listen: false)
                                                .removeFromWatchlist(
                                                    data.series);
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
                                          data.series.overview!.length < 2
                                              ? "No Overview"
                                              : data.series.overview!,
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
                                    itemCount: data.series.numberOfSeasons,
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
                                                    id: data.series.id!,
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
                                  child: Consumer<DetailSeriesNotifier>(
                                    builder: (context, data, child) {
                                      if (data.state == RequestState.loading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (data.state ==
                                          RequestState.loaded) {
                                        if (data.seriesRecom.isEmpty) {
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
                                                  data.seriesRecom[index];
                                              return CardSeries(series);
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
