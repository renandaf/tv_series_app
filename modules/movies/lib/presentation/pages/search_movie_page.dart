import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/movie_bloc.dart';
import 'package:movies/presentation/widgets/card_movie_list.dart';
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
                  context.read<SearchMovieBloc>().add(OnQueryChanged(query));
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
                child: BlocBuilder<SearchMovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is MovieLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieListHasData) {
                      if (state.result.isEmpty) {
                        return Center(
                            child: Text(
                          "No Data Found",
                          style: kH6,
                        ));
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final movie = state.result[index];
                            return MovieList(movie, index);
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
