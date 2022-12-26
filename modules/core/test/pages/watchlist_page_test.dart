import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/movies.dart';
import 'package:series/domain/entities/detail.dart';
import 'package:series/presentation/bloc/series_bloc.dart';

import '../dummy_object.dart';
import 'watchlist_page_test.mocks.dart';

@GenerateMocks([MovieWatchlistBloc, SeriesWatchlistBloc])
void main() {
  late MockMovieWatchlistBloc mockNotifier1;
  late MockSeriesWatchlistBloc mockNotifier2;

  setUp(() {
    mockNotifier1 = MockMovieWatchlistBloc();
    mockNotifier2 = MockSeriesWatchlistBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => mockNotifier1,
        ),
        BlocProvider<SeriesWatchlistBloc>(
          create: (context) => mockNotifier2,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display data when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier1.stream).thenAnswer(
        (_) => Stream.value(WatchlistMovieHasData(movieDetailList)));
    when(mockNotifier2.stream)
        .thenAnswer((_) => Stream.value(WatchlistSeriesHasData(detailList)));

    when(mockNotifier1.state)
        .thenReturn(WatchlistMovieHasData(movieDetailList));
    when(mockNotifier2.state).thenReturn(WatchlistSeriesHasData(detailList));

    final scrollFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const WatchlistPage()));

    expect(scrollFinder, findsWidgets);
  });

  testWidgets('Page should display error when data is error',
      (WidgetTester tester) async {
    when(mockNotifier1.stream)
        .thenAnswer((_) => Stream.value(const MovieError("error")));
    when(mockNotifier2.stream)
        .thenAnswer((_) => Stream.value(const SeriesError("error")));

    when(mockNotifier1.state).thenReturn(const MovieError("error"));
    when(mockNotifier2.state).thenReturn(const SeriesError("error"));

    final errorFinder = find.byKey(const Key("error"));

    await tester.pumpWidget(makeTestableWidget(const WatchlistPage()));

    expect(errorFinder, findsWidgets);
  });
}
