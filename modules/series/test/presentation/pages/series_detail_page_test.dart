import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/bloc/series_bloc.dart';
import 'package:series/presentation/pages/detail_series_page.dart';

import '../../dummy_data/dummy_object.dart';
import 'series_detail_page_test.mocks.dart';

@GenerateMocks(
    [SeriesDetailBloc, SeriesRecommendationBloc, SeriesWatchlistBloc])
void main() {
  late MockSeriesDetailBloc mockNotifier1;
  late MockSeriesRecommendationBloc mockNotifier2;
  late MockSeriesWatchlistBloc mockNotifier3;

  setUp(() {
    mockNotifier1 = MockSeriesDetailBloc();
    mockNotifier2 = MockSeriesRecommendationBloc();
    mockNotifier3 = MockSeriesWatchlistBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SeriesDetailBloc>(
          create: (context) => mockNotifier1,
        ),
        BlocProvider<SeriesRecommendationBloc>(
          create: (context) => mockNotifier2,
        ),
        BlocProvider<SeriesWatchlistBloc>(
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
    when(mockNotifier1.stream).thenAnswer((_) => Stream.value(SeriesLoading()));
    when(mockNotifier2.stream).thenAnswer((_) => Stream.value(SeriesLoading()));
    when(mockNotifier3.stream).thenAnswer((_) => Stream.value(SeriesLoading()));

    when(mockNotifier1.state).thenReturn(SeriesLoading());
    when(mockNotifier2.state).thenReturn(SeriesLoading());
    when(mockNotifier3.state).thenReturn(SeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const DetailPage(
      id: 1,
    )));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display data when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier1.stream)
        .thenAnswer((_) => Stream.value(DetailHasData(detail)));
    when(mockNotifier2.stream)
        .thenAnswer((_) => Stream.value(const SeriesListHasData(<Series>[])));
    when(mockNotifier3.stream)
        .thenAnswer((_) => Stream.value(const SeriesWatchlistStatus(false)));

    when(mockNotifier1.state).thenReturn(DetailHasData(detail));
    when(mockNotifier2.state).thenReturn(const SeriesListHasData(<Series>[]));
    when(mockNotifier3.state).thenReturn(const SeriesWatchlistStatus(false));

    final listViewFinder = find.byType(ListView);
    final scrollFinder = find.byType(SingleChildScrollView);

    await tester.pumpWidget(makeTestableWidget(const DetailPage(id: 1)));

    expect(listViewFinder, findsWidgets);
    expect(scrollFinder, findsWidgets);
  });

  testWidgets('Page should display error when data is error',
      (WidgetTester tester) async {
    when(mockNotifier1.stream)
        .thenAnswer((_) => Stream.value(const SeriesError("error")));
    when(mockNotifier2.stream)
        .thenAnswer((_) => Stream.value(const SeriesError("error")));
    when(mockNotifier3.stream)
        .thenAnswer((_) => Stream.value(const SeriesError("error")));

    when(mockNotifier1.state).thenReturn(const SeriesError("error"));
    when(mockNotifier2.state).thenReturn(const SeriesError("error"));
    when(mockNotifier3.state).thenReturn(const SeriesError("error"));

    final errorFinder = find.byKey(const Key("error"));

    await tester.pumpWidget(makeTestableWidget(const DetailPage(
      id: 1,
    )));

    expect(errorFinder, findsWidgets);
  });
}
