import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/widgets/card_series.dart';
import 'package:series/series.dart';

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
    Future.microtask(() {
      context.read<OnAirSeriesBloc>().add(OnOnAirSeries());
      context.read<PopularSeriesBloc>().add(OnPopularSeries());
      context.read<TopRatedSeriesBloc>().add(OnTopRatedSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
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
                      child: BlocBuilder<PopularSeriesBloc, SeriesState>(
                          builder: (context, state) {
                        if (state is SeriesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SeriesListHasData) {
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
                                          arguments:
                                              state.result[pagePosition].id,
                                        );
                                      },
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              GetSeriesDetail.backDropImage(
                                                  state.result[pagePosition]
                                                      .backdropPath!)),
                                    ));
                              });
                        } else {
                          return Center(
                            child: Text(
                              'Failed to Get Data',
                              style: kH6,
                              key: const Key("error"),
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
                  key: "top_rated_series",
                  title: 'Top Rated',
                  onTap: () {
                    Navigator.pushNamed(context, TopRatedPage.routeName);
                  }),
              SizedBox(
                height: 240,
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<TopRatedSeriesBloc, SeriesState>(
                          builder: (context, state) {
                        if (state is SeriesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SeriesListHasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.result.length,
                            itemBuilder: (BuildContext context, int index) {
                              Series series = state.result[index];
                              return CardSeries(series);
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              'Failed to Get Data',
                              style: kH6,
                              key: const Key("error"),
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
              _buildSubHeading(
                  title: 'Airing Today',
                  key: "on_air_series",
                  onTap: () {
                    Navigator.pushNamed(context, OnAirPage.routeName);
                  }),
              SizedBox(
                height: 240,
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<OnAirSeriesBloc, SeriesState>(
                          builder: (context, state) {
                        if (state is SeriesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SeriesListHasData) {
                          return ListView.builder(
                            key: const Key("detail"),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.result.length,
                            itemBuilder: (BuildContext context, int index) {
                              Series series = state.result[index];
                              return CardSeries(series);
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              'Failed to Get Data',
                              style: kH6,
                              key: const Key("error"),
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

  InkWell _buildSubHeading(
      {required String title, required Function() onTap, required String key}) {
    return InkWell(
      key: Key(key),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kH6,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'See More',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
