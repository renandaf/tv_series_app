import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/bloc/series_bloc.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/widgets/card_series_list.dart';

class TopRatedPage extends StatefulWidget {
  static const routeName = '/top_rated';

  const TopRatedPage({super.key});

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedSeriesBloc>().add(OnTopRatedSeries());
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
            'Top Rated Series',
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
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: BlocBuilder<TopRatedSeriesBloc, SeriesState>(
              builder: (context, state) {
            if (state is SeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeriesListHasData) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (BuildContext context, int index) {
                  Series series = state.result[index];
                  return SeriesList(series, index);
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
        ));
  }
}
