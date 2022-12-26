import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/bloc/series_bloc.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/widgets/card_series_list.dart';

class OnAirPage extends StatefulWidget {
  static const routeName = '/on_air';

  const OnAirPage({super.key});

  @override
  State<OnAirPage> createState() => _OnAirPageState();
}

class _OnAirPageState extends State<OnAirPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OnAirSeriesBloc>().add(OnOnAirSeries());
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
            'On Air Series',
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
          child: BlocBuilder<OnAirSeriesBloc, SeriesState>(
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
