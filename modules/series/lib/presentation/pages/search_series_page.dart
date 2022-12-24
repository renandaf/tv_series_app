import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/pages/search_movie_page.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/provider/search_series_provider.dart';
import 'package:series/presentation/widgets/card_series_list.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }, // Men
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search Series',
            style: kH3,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, SearchMoviePage.routeName);
              },
              icon: const Icon(
                Icons.arrow_forward,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (query) {
                  Provider.of<SearchSeriesNotifier>(context, listen: false)
                      .fetchSearchSeries(query);
                },
                decoration: const InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 15),
              Text(
                'Search Result',
                style: kH6,
              ),
              Expanded(
                child: Consumer<SearchSeriesNotifier>(
                  builder: (context, data, child) {
                    if (data.state == RequestState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (data.state == RequestState.loaded) {
                      if (data.series.isEmpty) {
                        return Center(
                            child: Text(
                          "No Data Found",
                          style: kH6,
                        ));
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final series = data.series[index];
                            return SeriesList(series);
                          },
                          itemCount: data.series.length,
                        );
                      }
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
      ),
    );
  }
}
