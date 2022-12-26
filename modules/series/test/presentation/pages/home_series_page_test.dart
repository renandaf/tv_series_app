import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/presentation/bloc/series_bloc.dart';
import 'package:series/presentation/pages/home_series_page.dart';
import 'package:series/presentation/widgets/card_series.dart';

import '../../dummy_data/dummy_object.dart';
import 'home_series_page_test.mocks.dart';

@GenerateMocks([OnAirSeriesBloc, PopularSeriesBloc, TopRatedSeriesBloc])
void main() {
  late MockOnAirSeriesBloc mockNotifier1;
  late MockPopularSeriesBloc mockNotifier2;
  late MockTopRatedSeriesBloc mockNotifier3;

  setUp(() {
    mockNotifier1 = MockOnAirSeriesBloc();
    mockNotifier2 = MockPopularSeriesBloc();
    mockNotifier3 = MockTopRatedSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnAirSeriesBloc>(
          create: (context) => mockNotifier1,
        ),
        BlocProvider<PopularSeriesBloc>(
          create: (context) => mockNotifier2,
        ),
        BlocProvider<TopRatedSeriesBloc>(
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

    await tester.pumpWidget(makeTestableWidget(const HomePageSeries()));
    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display list when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier1.stream)
        .thenAnswer((_) => Stream.value(SeriesListHasData(seriesList)));
    when(mockNotifier2.stream)
        .thenAnswer((_) => Stream.value(SeriesListHasData(seriesList)));
    when(mockNotifier3.stream)
        .thenAnswer((_) => Stream.value(SeriesListHasData(seriesList)));

    when(mockNotifier1.state).thenReturn(SeriesListHasData(seriesList));
    when(mockNotifier2.state).thenReturn(SeriesListHasData(seriesList));
    when(mockNotifier3.state).thenReturn(SeriesListHasData(seriesList));

    final listViewFinder = find.byType(ListView);
    final pageViewFinder = find.byType(PageView);
    final cardFinder = find.byType(CardSeries);

    await tester.pumpWidget(makeTestableWidget(const HomePageSeries()));
    expect(listViewFinder, findsWidgets);
    expect(cardFinder, findsWidgets);
    expect(pageViewFinder, findsOneWidget);
  });

  testWidgets('Page should display error when data is error',
      (WidgetTester tester) async {
    when(mockNotifier1.stream)
        .thenAnswer((_) => Stream.value(const SeriesError("Error")));
    when(mockNotifier2.stream)
        .thenAnswer((_) => Stream.value(const SeriesError("Error")));
    when(mockNotifier3.stream)
        .thenAnswer((_) => Stream.value(const SeriesError("Error")));

    when(mockNotifier1.state).thenReturn(const SeriesError("Error"));
    when(mockNotifier2.state).thenReturn(const SeriesError("Error"));
    when(mockNotifier3.state).thenReturn(const SeriesError("Error"));

    final errorFinder = find.byKey(const Key("error"));

    await tester.pumpWidget(makeTestableWidget(const HomePageSeries()));
    expect(errorFinder, findsWidgets);
  });
}
