import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/pages/home_movies_page.dart';
import 'package:movies/presentation/provider/movie_list_notifier.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_object.dart';
import 'home_movie_page_test.mocks.dart';

@GenerateMocks([MovieListNotifier])
void main() {
  late MockMovieListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieListNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display list movie when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.loaded);
    when(mockNotifier.nowPlayingMovies).thenReturn(testMovie5);
    when(mockNotifier.popularMoviesState).thenReturn(RequestState.loaded);
    when(mockNotifier.popularMovies).thenReturn(testMovie5);
    when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.loaded);
    when(mockNotifier.topRatedMovies).thenReturn(testMovie5);

    await tester.pumpWidget(makeTestableWidget(const HomePageMovies()));
  });
}
