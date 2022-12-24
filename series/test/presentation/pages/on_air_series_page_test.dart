import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/pages/on_air_series_page.dart';
import 'package:series/presentation/provider/on_air_series_provider.dart';

import 'on_air_series_page_test.mocks.dart';

@GenerateMocks([OnAirSeriesNotifier])
void main() {
  late MockOnAirSeriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockOnAirSeriesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<OnAirSeriesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.series).thenReturn(<Series>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const OnAirPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
