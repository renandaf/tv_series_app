import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/provider/search_series_provider.dart';

import 'search_series_page_test.mocks.dart';

@GenerateMocks([SearchSeriesNotifier])
void main() {
  late MockSearchSeriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSearchSeriesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SearchSeriesNotifier>.value(
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

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));
  });
}
