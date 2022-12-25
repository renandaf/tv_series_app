import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:series/series.dart';
import 'package:sizer/sizer.dart';
import 'package:tv_series_app/firebase_options.dart';
import 'package:tv_series_app/injection.dart' as injection;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => injection.locator<MovieDetailBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<SearchMovieBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<TopRatedMovieBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<NowPlayingMovieBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<PopularMovieBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<MovieWatchlistBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<MovieRecommendationBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<SeriesDetailBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<SearchSeriesBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<TopRatedSeriesBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<OnAirSeriesBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<PopularSeriesBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<SeriesWatchlistBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<SeriesRecommendationBloc>(),
          ),
          BlocProvider(
            create: (_) => injection.locator<SeasonDetailBloc>(),
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
