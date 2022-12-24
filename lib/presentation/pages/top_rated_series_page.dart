import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/common/constants.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/presentation/pages/search_series_page.dart';
import 'package:tv_series_app/presentation/provider/top_rated_series_provider.dart';
import 'package:tv_series_app/presentation/widgets/card_series_list.dart';
import 'package:tv_series_app/presentation/widgets/drawer.dart';

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
    Future.microtask(() =>
        Provider.of<TopRatedSeriesNotifier>(context, listen: false)
            .fetchTopRatedSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SafeArea(child: CustomDrawer()),
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
          child: Consumer<TopRatedSeriesNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == RequestState.Loaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final series = data.series[index];
                    return SeriesList(series);
                  },
                  itemCount: data.series.length,
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
        ));
  }
}
