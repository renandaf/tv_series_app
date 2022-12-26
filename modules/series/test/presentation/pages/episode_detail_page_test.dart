import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/presentation/bloc/series_bloc.dart';
import 'package:series/presentation/pages/episode_detail_page.dart';

import '../../dummy_data/dummy_object.dart';
import 'episode_detail_page_test.mocks.dart';

@GenerateMocks([SeasonDetailBloc])
void main() {
  late MockSeasonDetailBloc mockNotifier;

  setUp(() {
    mockNotifier = MockSeasonDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SeasonDetailBloc>(
      create: (context) => mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display Loading when data is loading',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(SeriesLoading()));
    when(mockNotifier.state).thenReturn(SeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const SeasonPage(
      id: 1,
      seasonNumber: 1,
    )));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.stream)
        .thenAnswer((_) => Stream.value(const SeasonHasData(testSeason)));
    when(mockNotifier.state).thenReturn(const SeasonHasData(testSeason));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SeasonPage(
      id: 1,
      seasonNumber: 1,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should error Loading when data is error',
      (WidgetTester tester) async {
    when(mockNotifier.stream)
        .thenAnswer((_) => Stream.value(const SeriesError("error")));
    when(mockNotifier.state).thenReturn(const SeriesError("error"));

    final errorFinder = find.byKey(const Key("error"));

    await tester.pumpWidget(makeTestableWidget(const SeasonPage(
      id: 1,
      seasonNumber: 1,
    )));

    expect(errorFinder, findsOneWidget);
  });
}
