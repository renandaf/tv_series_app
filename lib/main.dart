import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';
import 'package:series/series.dart';
import 'package:sizer/sizer.dart';
import 'package:tv_series_app/injection.dart' as injection;

void main() {
  injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => injection.locator<TopRatedSeriesNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (context) => injection.locator<PopularSeriesNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (context) => injection.locator<OnAirSeriesNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (context) => injection.locator<DetailSeriesNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (context) => injection.locator<WatchListNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (context) => injection.locator<SearchSeriesNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => injection.locator<MovieListNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => injection.locator<MovieDetailNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => injection.locator<MovieSearchNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => injection.locator<TopRatedMoviesNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => injection.locator<PopularMoviesNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => injection.locator<WatchlistMovieNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => injection.locator<SeriesListNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => injection.locator<NowPlayingMovieNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => injection.locator<SeasonDetailNotifier>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TV Series App',
          theme: ThemeData(
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
          ),
          home: const HomePageSeries(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case HomePageSeries.routeName:
                return MaterialPageRoute(
                    builder: (_) => const HomePageSeries());
              case HomePageMovies.routeName:
                return MaterialPageRoute(
                    builder: (_) => const HomePageMovies());
              case SearchPage.routeName:
                return CupertinoPageRoute(builder: (_) => const SearchPage());
              case TopRatedPage.routeName:
                return CupertinoPageRoute(builder: (_) => const TopRatedPage());
              case OnAirPage.routeName:
                return CupertinoPageRoute(builder: (_) => const OnAirPage());
              case DetailPage.routeName:
                return CupertinoPageRoute(
                    builder: (_) => DetailPage(id: settings.arguments as int));
              case WatchlistPage.routeName:
                return CupertinoPageRoute(
                    builder: (_) => const WatchlistPage());
              case PopularPage.routeName:
                return CupertinoPageRoute(builder: (_) => const PopularPage());
              case PopularMoviePage.routeName:
                return CupertinoPageRoute(
                    builder: (_) => const PopularMoviePage());
              case TopRatedMoviePage.routeName:
                return CupertinoPageRoute(
                    builder: (_) => const TopRatedMoviePage());
              case NowPlayingMoviePage.routeName:
                return CupertinoPageRoute(
                    builder: (_) => const NowPlayingMoviePage());
              case SearchMoviePage.routeName:
                return CupertinoPageRoute(
                    builder: (_) => const SearchMoviePage());
              case DetailMoviePage.routeName:
                return CupertinoPageRoute(
                    builder: (_) =>
                        DetailMoviePage(id: settings.arguments as int));
            }
            return null;
          },
        ),
      );
    });
  }
}
