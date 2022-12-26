import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/presentation/bloc/series_bloc.dart';
import 'package:series/presentation/pages/on_air_series_page.dart';

import '../../dummy_data/dummy_object.dart';
import 'on_air_series_page_test.mocks.dart';

@GenerateMocks([OnAirSeriesBloc])
void main() {
  late MockOnAirSeriesBloc mockNotifier;

  setUp(() {
    mockNotifier = MockOnAirSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<OnAirSeriesBloc>(
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

    await tester.pumpWidget(makeTestableWidget(const OnAirPage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.stream)
        .thenAnswer((_) => Stream.value(SeriesListHasData(seriesList)));
    when(mockNotifier.state).thenReturn(SeriesListHasData(seriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const OnAirPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should error Loading when data is error',
      (WidgetTester tester) async {
    when(mockNotifier.stream)
        .thenAnswer((_) => Stream.value(const SeriesError("error")));
    when(mockNotifier.state).thenReturn(const SeriesError("error"));

    final errorFinder = find.byKey(const Key("error"));

    await tester.pumpWidget(makeTestableWidget(const OnAirPage()));

    expect(errorFinder, findsOneWidget);
  });
}
