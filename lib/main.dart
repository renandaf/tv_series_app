import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tv_series_app/common/constants.dart';
import 'package:tv_series_app/common/utils.dart';
import 'package:tv_series_app/presentation/pages/detail_movie_page.dart';
import 'package:tv_series_app/presentation/pages/home_movies_page.dart';
import 'package:tv_series_app/presentation/pages/now_playing_movie_page.dart';
import 'package:tv_series_app/presentation/pages/on_air_series_page.dart';
import 'package:tv_series_app/presentation/pages/detail_series_page.dart';
import 'package:tv_series_app/presentation/pages/home_series_page.dart';
import 'package:tv_series_app/presentation/pages/popular_movie_page.dart';
import 'package:tv_series_app/presentation/pages/popular_series_page.dart';
import 'package:tv_series_app/presentation/pages/search_movie_page.dart';
import 'package:tv_series_app/presentation/pages/search_series_page.dart';
import 'package:tv_series_app/presentation/pages/top_rated_movie_page.dart';
import 'package:tv_series_app/presentation/pages/top_rated_series_page.dart';
import 'package:tv_series_app/presentation/pages/watchlist_page.dart';
import 'package:tv_series_app/presentation/provider/detail_series_provider.dart';
import 'package:tv_series_app/presentation/provider/movie_detail_notifier.dart';
import 'package:tv_series_app/presentation/provider/movie_list_notifier.dart';
import 'package:tv_series_app/presentation/provider/movie_search_notifier.dart';
import 'package:tv_series_app/presentation/provider/now_playing_movie_notifier.dart';
import 'package:tv_series_app/presentation/provider/on_air_series_provider.dart';
import 'package:tv_series_app/presentation/provider/popular_movies_notifier.dart';
import 'package:tv_series_app/presentation/provider/popular_series_provider.dart';
import 'package:tv_series_app/presentation/provider/search_series_provider.dart';
import 'package:tv_series_app/presentation/provider/series_list_notifier.dart';
import 'package:tv_series_app/presentation/provider/top_rated_movies_notifier.dart';
import 'package:tv_series_app/presentation/provider/top_rated_series_provider.dart';
import 'package:tv_series_app/injection.dart' as injection;
import 'package:tv_series_app/presentation/provider/watchlist_movie_notifier.dart';
import 'package:tv_series_app/presentation/provider/watchlist_provider.dart';

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
