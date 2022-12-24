import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/pages/now_playing_movie_page.dart';
import 'package:movies/presentation/provider/now_playing_movie_notifier.dart';
import 'package:provider/provider.dart';

import 'now_playing_movie_page_test.mocks.dart';

@GenerateMocks([NowPlayingMovieNotifier])
void main() {
  late MockNowPlayingMovieNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockNowPlayingMovieNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<NowPlayingMovieNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.movie).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviePage()));

    expect(listViewFinder, findsOneWidget);
  });
}
