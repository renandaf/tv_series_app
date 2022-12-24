import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/pages/popular_movie_page.dart';
import 'package:movies/presentation/provider/popular_movies_notifier.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_object.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesNotifier])
void main() {
  late MockPopularMoviesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPopularMoviesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularMoviesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.movies).thenReturn(testMovieList);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviePage()));

    expect(listViewFinder, findsOneWidget);
  });
}
