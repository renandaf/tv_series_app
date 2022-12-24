import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/presentation/pages/home_series_page.dart';
import 'package:tv_series_app/presentation/provider/series_list_notifier.dart';

import '../../dummy_data/dummy_object.dart';
import 'home_series_page_test.mocks.dart';

@GenerateMocks([SeriesListNotifier])
void main() {
  late MockSeriesListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSeriesListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SeriesListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display list movie when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.onAirState).thenReturn(RequestState.Loaded);
    when(mockNotifier.onAirSeries).thenReturn(seriesList5);
    when(mockNotifier.popularSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularSeries).thenReturn(seriesList5);
    when(mockNotifier.topRatedSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedSeries).thenReturn(seriesList5);

    await tester.pumpWidget(_makeTestableWidget(const HomePageSeries()));
  });
}
