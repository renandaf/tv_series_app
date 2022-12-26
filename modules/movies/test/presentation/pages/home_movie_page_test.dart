import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/widgets/card_movie.dart';

import '../../dummy_data/dummy_object.dart';
import 'home_movie_page_test.mocks.dart';

@GenerateMocks([NowPlayingMovieBloc, PopularMovieBloc, TopRatedMovieBloc])
void main() {
  late MockNowPlayingMovieBloc mockNotifier1;
  late MockPopularMovieBloc mockNotifier2;
  late MockTopRatedMovieBloc mockNotifier3;

  setUp(() {
    mockNotifier1 = MockNowPlayingMovieBloc();
    mockNotifier2 = MockPopularMovieBloc();
    mockNotifier3 = MockTopRatedMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMovieBloc>(
          create: (context) => mockNotifier1,
        ),
        BlocProvider<PopularMovieBloc>(
          create: (context) => mockNotifier2,
        ),
        BlocProvider<TopRatedMovieBloc>(
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

    await tester.pumpWidget(makeTestableWidget(const HomePageMovies()));
    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display list when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier1.stream)
        .thenAnswer((_) => Stream.value(MovieListHasData(testMovieList)));
    when(mockNotifier2.stream)
        .thenAnswer((_) => Stream.value(MovieListHasData(testMovieList)));
    when(mockNotifier3.stream)
        .thenAnswer((_) => Stream.value(MovieListHasData(testMovieList)));

    when(mockNotifier1.state).thenReturn(MovieListHasData(testMovieList));
    when(mockNotifier2.state).thenReturn(MovieListHasData(testMovieList));
    when(mockNotifier3.state).thenReturn(MovieListHasData(testMovieList));

    final listViewFinder = find.byType(ListView);
    final pageViewFinder = find.byType(PageView);
    final cardFinder = find.byType(CardMovie);

    await tester.pumpWidget(makeTestableWidget(const HomePageMovies()));
    expect(listViewFinder, findsWidgets);
    expect(cardFinder, findsWidgets);
    expect(pageViewFinder, findsOneWidget);
  });

  testWidgets('Page should display error when data is error',
      (WidgetTester tester) async {
    when(mockNotifier1.stream)
        .thenAnswer((_) => Stream.value(const MovieError("Error")));
    when(mockNotifier2.stream)
        .thenAnswer((_) => Stream.value(const MovieError("Error")));
    when(mockNotifier3.stream)
        .thenAnswer((_) => Stream.value(const MovieError("Error")));

    when(mockNotifier1.state).thenReturn(const MovieError("Error"));
    when(mockNotifier2.state).thenReturn(const MovieError("Error"));
    when(mockNotifier3.state).thenReturn(const MovieError("Error"));

    final errorFinder = find.byKey(const Key("error"));

    await tester.pumpWidget(makeTestableWidget(const HomePageMovies()));
    expect(errorFinder, findsWidgets);
  });
}
