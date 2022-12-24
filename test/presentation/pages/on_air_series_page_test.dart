import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/domain/entities/series.dart';
import 'package:tv_series_app/presentation/pages/on_air_series_page.dart';
import 'package:tv_series_app/presentation/provider/on_air_series_provider.dart';

import 'on_air_series_page_test.mocks.dart';

@GenerateMocks([OnAirSeriesNotifier])
void main() {
  late MockOnAirSeriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockOnAirSeriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<OnAirSeriesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(<Series>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const OnAirPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
