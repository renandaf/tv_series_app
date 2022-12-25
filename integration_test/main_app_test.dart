import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movies/movies.dart';
import 'package:series/presentation/pages/detail_series_page.dart';
import 'package:series/presentation/pages/episode_detail_page.dart';
import 'package:series/presentation/pages/home_series_page.dart';
import 'package:series/presentation/pages/on_air_series_page.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';
import 'package:series/presentation/widgets/watchlist_card.dart';
import 'package:tv_series_app/main.dart' as app;

void main() {
  group(
    'Integration Test',
    () {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      testWidgets('App flow', (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("detail")));
        await tester.pumpAndSettle();
        expect(find.byType(DetailPage), findsOneWidget);

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();
        expect(find.text("Remove from Watchlist"), findsOneWidget);

        await tester.tap(find.byKey(const Key("season")));
        await tester.pumpAndSettle();
        expect(find.byType(SeasonPage), findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        expect(find.byType(DetailPage), findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_back_ios));
        await tester.pumpAndSettle();
        expect(find.byType(HomePageSeries), findsOneWidget);

        ScaffoldState state = tester.firstState(find.byType(Scaffold));
        state.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("popular_movie")));
        await tester.pumpAndSettle();
        expect(find.byType(PopularMoviePage), findsOneWidget);

        await tester.tap(find.byKey(const Key("movie_${1}")));
        await tester.pumpAndSettle();
        expect(find.byType(DetailMoviePage), findsOneWidget);

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();
        expect(find.text("Remove from Watchlist"), findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_back_ios));
        await tester.pumpAndSettle();
        expect(find.byType(PopularMoviePage), findsOneWidget);

        await tester.scrollUntilVisible(
            find.byKey(const Key('movie_${1}')), 500,
            scrollable: find.byType(Scrollable).last);
        await tester.pumpAndSettle();

        state = tester.firstState(find.byType(Scaffold));
        state.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("nowplaying_movie")));
        await tester.pumpAndSettle();
        expect(find.byType(NowPlayingMoviePage), findsOneWidget);

        await tester.scrollUntilVisible(
            find.byKey(const Key('movie_${1}')), 500,
            scrollable: find.byType(Scrollable).last);
        await tester.pumpAndSettle();

        state = tester.firstState(find.byType(Scaffold));
        state.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("toprated_movie")));
        await tester.pumpAndSettle();
        expect(find.byType(TopRatedMoviePage), findsOneWidget);

        await tester.scrollUntilVisible(
            find.byKey(const Key('movie_${1}')), 500,
            scrollable: find.byType(Scrollable).last);
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();
        expect(find.byType(SearchMoviePage), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);

        await tester.enterText(find.byType(TextField), "a");
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.arrow_back), findsOneWidget);
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        expect(find.byType(TopRatedMoviePage), findsOneWidget);

        state = tester.firstState(find.byType(Scaffold));
        state.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("popular_series")));
        await tester.pumpAndSettle();
        expect(find.byType(PopularPage), findsOneWidget);

        await tester.scrollUntilVisible(
            find.byKey(const Key('series_${1}')), 500,
            scrollable: find.byType(Scrollable).last);
        await tester.pumpAndSettle();

        state = tester.firstState(find.byType(Scaffold));
        state.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("onair_series")));
        await tester.pumpAndSettle();
        expect(find.byType(OnAirPage), findsOneWidget);

        await tester.scrollUntilVisible(
            find.byKey(const Key('series_${1}')), 500,
            scrollable: find.byType(Scrollable).last);
        await tester.pumpAndSettle();

        state = tester.firstState(find.byType(Scaffold));
        state.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("toprated_series")));
        await tester.pumpAndSettle();
        expect(find.byType(TopRatedPage), findsOneWidget);

        await tester.scrollUntilVisible(
            find.byKey(const Key('series_${1}')), 500,
            scrollable: find.byType(Scrollable).last);
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();
        expect(find.byType(SearchPage), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);

        await tester.enterText(find.byType(TextField), "a");
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.arrow_back), findsOneWidget);
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        expect(find.byType(TopRatedPage), findsOneWidget);

        state = tester.firstState(find.byType(Scaffold));
        state.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("watchlist")));
        await tester.pumpAndSettle();
        expect(find.byType(WatchlistPage), findsOneWidget);
        expect(find.byType(WatchListMovie), findsOneWidget);
        expect(find.byType(WatchList), findsOneWidget);
      });
    },
  );
}
