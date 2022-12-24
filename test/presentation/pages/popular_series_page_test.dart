import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/presentation/pages/popular_series_page.dart';
import 'package:tv_series_app/presentation/provider/popular_series_provider.dart';

import '../../dummy_data/dummy_object.dart';
import 'popular_series_page_test.mocks.dart';

@GenerateMocks([PopularSeriesNotifier])
void main() {
  late MockPopularSeriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPopularSeriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularSeriesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(seriesList);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
