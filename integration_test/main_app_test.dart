import 'package:core/core.dart';
import 'package:core/widgets/watchlist_card.dart';
import 'package:core/widgets/watchlist_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movies/movies.dart';
import 'package:series/presentation/pages/detail_series_page.dart';
import 'package:series/presentation/pages/episode_detail_page.dart';
import 'package:series/presentation/pages/on_air_series_page.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';
import 'package:series/presentation/widgets/card_episode.dart';
import 'package:tv_series_app/main.dart' as app;

void main() {
  group(
    'Integration Test',
    () {
      final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      testWidgets('App flow', (tester) async {
        await binding.traceAction(() async {
          app.main();
          await tester.pumpAndSettle();

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

          await tester.tap(find.byKey(const Key('series_${1}')));
          await tester.pumpAndSettle();
          expect(find.byType(DetailPage), findsOneWidget);

          await tester.tap(find.byType(ElevatedButton));
          await tester.pumpAndSettle();
          expect(find.text("Remove from Watchlist"), findsOneWidget);

          await tester.drag(
              find.byKey(const Key('scroll')), const Offset(0.0, -200));
          await tester.pump();
          await tester.tap(find.byKey(const Key("season_${0}")));
          await tester.pumpAndSettle();
          expect(find.byType(SeasonPage), findsOneWidget);
          expect(find.byType(EpisodeList), findsWidgets);

          await tester.tap(find.byIcon(Icons.arrow_back));
          await tester.pumpAndSettle();
          expect(find.byType(DetailPage), findsOneWidget);

          await tester.drag(
              find.byKey(const Key('scroll')), const Offset(0.0, 200));
          await tester.pump();
          await tester.tap(find.byIcon(Icons.arrow_back_ios));
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
      });
    },
  );
}
