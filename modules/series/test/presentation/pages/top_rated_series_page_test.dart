import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';
import 'package:series/presentation/provider/top_rated_series_provider.dart';

import 'top_rated_series_page_test.mocks.dart';

@GenerateMocks([TopRatedSeriesNotifier])
void main() {
  late MockTopRatedSeriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedSeriesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedSeriesNotifier>.value(
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

    await tester.pumpWidget(makeTestableWidget(const TopRatedPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
