import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/presentation/pages/detail_series_page.dart';
import 'package:series/presentation/pages/on_air_series_page.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';
import 'package:series/presentation/provider/series_list_notifier.dart';
import 'package:series/presentation/widgets/card_series.dart';

class HomePageSeries extends StatefulWidget {
  static const routeName = '/homeSeries';

  const HomePageSeries({super.key});

  @override
  State<HomePageSeries> createState() => _HomePageSeriesState();
}

class _HomePageSeriesState extends State<HomePageSeries> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<SeriesListNotifier>(context, listen: false)
            .fetchTopRatedSeries());
    Future.microtask(() =>
        Provider.of<SeriesListNotifier>(context, listen: false)
            .fetchOnAirSeries());
    Future.microtask(() =>
        Provider.of<SeriesListNotifier>(context, listen: false)
            .fetchPopularSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'TV Series',
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
                      child: Consumer<SeriesListNotifier>(
                        builder: (context, data, child) {
                          if (data.popularSeriesState == RequestState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.popularSeriesState ==
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
                                                .popularSeries[pagePosition].id,
                                          );
                                        },
                                        child: CachedNetworkImage(
                                            imageUrl: GetSeriesDetail
                                                .backDropImage(data
                                                    .popularSeries[pagePosition]
                                                    .backdropPath)),
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
                  title: 'Airing Today',
                  onTap: () {
                    Navigator.pushNamed(context, OnAirPage.routeName);
                  }),
              SizedBox(
                height: 240,
                child: Column(
                  children: [
                    Expanded(
                      child: Consumer<SeriesListNotifier>(
                        builder: (context, data, child) {
                          if (data.onAirState == RequestState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.onAirState == RequestState.loaded) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final series = data.onAirSeries[index];
                                return CardSeries(series);
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
                    Navigator.pushNamed(context, TopRatedPage.routeName);
                  }),
              SizedBox(
                height: 240,
                child: Column(
                  children: [
                    Expanded(
                      child: Consumer<SeriesListNotifier>(
                        builder: (context, data, child) {
                          if (data.topRatedSeriesState ==
                              RequestState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.topRatedSeriesState ==
                              RequestState.loaded) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final series = data.topRatedSeries[index];
                                return CardSeries(series);
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
