import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/widgets/card_series_list.dart';
import 'package:series/series.dart';

class PopularPage extends StatefulWidget {
  static const routeName = '/popular';

  const PopularPage({super.key});

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularSeriesBloc>().add(OnPopularSeries());
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
            'Popular Series',
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
          child: BlocBuilder<PopularSeriesBloc, SeriesState>(
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
                ),
              );
            }
          }),
        ));
  }
}
