import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/provider/popular_series_provider.dart';

import '../../dummy_data/dummy_object.dart';
import 'popular_series_page_test.mocks.dart';

@GenerateMocks([PopularSeriesNotifier])
void main() {
  late MockPopularSeriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPopularSeriesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularSeriesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.series).thenReturn(seriesList);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
