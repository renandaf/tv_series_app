import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_object.dart';
import 'detail_movie_page_test.mocks.dart';

@GenerateMocks([MovieDetailBloc, MovieRecommendationBloc, MovieWatchlistBloc])
void main() {
  late MockMovieDetailBloc mockNotifier1;
  late MockMovieRecommendationBloc mockNotifier2;
  late MockMovieWatchlistBloc mockNotifier3;

  setUp(() {
    mockNotifier1 = MockMovieDetailBloc();
    mockNotifier2 = MockMovieRecommendationBloc();
    mockNotifier3 = MockMovieWatchlistBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockNotifier1,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (context) => mockNotifier2,
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => mockNotifier3,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display Loading when data is loading',
      (WidgetTester tester) async {
    when(mockNotifier1.stream).thenAnswer((_) => Stream.value(MovieLoading()));
    when(mockNotifier2.stream).thenAnswer((_) => Stream.value(MovieLoading()));
    when(mockNotifier3.stream).thenAnswer((_) => Stream.value(MovieLoading()));

    when(mockNotifier1.state).thenReturn(MovieLoading());
    when(mockNotifier2.state).thenReturn(MovieLoading());
    when(mockNotifier3.state).thenReturn(MovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const DetailMoviePage(
      id: 1,
    )));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display data when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier1.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(testMovieDetail)));
    when(mockNotifier2.stream)
        .thenAnswer((_) => Stream.value(const MovieListHasData(<Movie>[])));
    when(mockNotifier3.stream)
        .thenAnswer((_) => Stream.value(const MovieWatchlistStatus(false)));

    when(mockNotifier1.state).thenReturn(MovieDetailHasData(testMovieDetail));
    when(mockNotifier2.state).thenReturn(const MovieListHasData(<Movie>[]));
    when(mockNotifier3.state).thenReturn(const MovieWatchlistStatus(false));

    final scrollFinder = find.byType(SingleChildScrollView);

    await tester.pumpWidget(makeTestableWidget(const DetailMoviePage(id: 1)));

    expect(scrollFinder, findsWidgets);
  });

  testWidgets('Page should display error when data is error',
      (WidgetTester tester) async {
    when(mockNotifier1.stream)
        .thenAnswer((_) => Stream.value(const MovieError("error")));
    when(mockNotifier2.stream)
        .thenAnswer((_) => Stream.value(const MovieError("error")));
    when(mockNotifier3.stream)
        .thenAnswer((_) => Stream.value(const MovieError("error")));

    when(mockNotifier1.state).thenReturn(const MovieError("error"));
    when(mockNotifier2.state).thenReturn(const MovieError("error"));
    when(mockNotifier3.state).thenReturn(const MovieError("error"));

    final errorFinder = find.byKey(const Key("error"));

    await tester.pumpWidget(makeTestableWidget(const DetailMoviePage(
      id: 1,
    )));

    expect(errorFinder, findsWidgets);
  });
}
