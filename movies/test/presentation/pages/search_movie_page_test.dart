import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/pages/search_movie_page.dart';
import 'package:movies/presentation/provider/movie_search_notifier.dart';
import 'package:provider/provider.dart';

import 'search_movie_page_test.mocks.dart';

@GenerateMocks([MovieSearchNotifier])
void main() {
  late MockMovieSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieSearchNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieSearchNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.searchResult).thenReturn(<Movie>[]);

    await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));
  });
}
