import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/provider/movie_search_notifier.dart';
import 'package:movies/presentation/widgets/card_movie_list.dart';
import 'package:provider/provider.dart';
import 'package:series/series.dart';

class SearchMoviePage extends StatelessWidget {
  static const routeName = '/search_movie';

  const SearchMoviePage({super.key});

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
            'Search Movie',
            style: kH3,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, SearchPage.routeName);
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
                  Provider.of<MovieSearchNotifier>(context, listen: false)
                      .fetchMovieSearch(query);
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
                child: Consumer<MovieSearchNotifier>(
                  builder: (context, data, child) {
                    if (data.state == RequestState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (data.state == RequestState.loaded) {
                      if (data.searchResult.isEmpty) {
                        return Center(
                            child: Text(
                          "No Data Found",
                          style: kH6,
                        ));
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final movie = data.searchResult[index];
                            return MovieList(movie, index);
                          },
                          itemCount: data.searchResult.length,
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
