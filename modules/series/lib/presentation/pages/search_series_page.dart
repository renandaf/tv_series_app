import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/pages/search_movie_page.dart';
import 'package:series/presentation/widgets/card_series_list.dart';
import 'package:series/series.dart';

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
                  context
                      .read<SearchSeriesBloc>()
                      .add(OnQuerySeriesChanged(query));
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
                child: BlocBuilder<SearchSeriesBloc, SeriesState>(
                  builder: (context, state) {
                    if (state is SeriesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SeriesListHasData) {
                      if (state.result.isEmpty) {
                        return Center(
                            child: Text(
                          "No Data Found",
                          style: kH6,
                        ));
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final series = state.result[index];
                            return SeriesList(series, index);
                          },
                          itemCount: state.result.length,
                        );
                      }
                    } else {
                      return Center(
                          child: Text(
                        "No Data Found",
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
