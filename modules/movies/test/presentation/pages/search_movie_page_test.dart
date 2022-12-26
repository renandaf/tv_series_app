import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/movie_bloc.dart';
import 'package:movies/presentation/pages/search_movie_page.dart';

import '../../dummy_data/dummy_object.dart';
import 'search_movie_page_test.mocks.dart';

@GenerateMocks([SearchMovieBloc])
void main() {
  late MockSearchMovieBloc mockNotifier;

  setUp(() {
    mockNotifier = MockSearchMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchMovieBloc>(
      create: (context) => mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display Loading when data is loading',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(MovieLoading()));
    when(mockNotifier.state).thenReturn(MovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.stream)
        .thenAnswer((_) => Stream.value(MovieListHasData(testMovieList)));
    when(mockNotifier.state).thenReturn(MovieListHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should error Loading when data is error',
      (WidgetTester tester) async {
    when(mockNotifier.stream)
        .thenAnswer((_) => Stream.value(const MovieError("error")));
    when(mockNotifier.state).thenReturn(const MovieError("error"));

    final errorFinder = find.byKey(const Key("error"));

    await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

    expect(errorFinder, findsOneWidget);
  });
}
