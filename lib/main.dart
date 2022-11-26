import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_app/common/constants.dart';
import 'package:tv_series_app/common/utils.dart';
import 'package:tv_series_app/pages/airing_today_page.dart';
import 'package:tv_series_app/pages/detail_series_page.dart';
import 'package:tv_series_app/pages/home_page.dart';
import 'package:tv_series_app/pages/new_release_page.dart';
import 'package:tv_series_app/pages/search_page.dart';
import 'package:tv_series_app/pages/top_rated_series_page.dart';
import 'package:tv_series_app/pages/watchlist_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TV Series App',
      theme: ThemeData(
        colorScheme: kColorScheme,
        primaryColor: kRichBlack,
        scaffoldBackgroundColor: kRichBlack,
        textTheme: kTextTheme,
      ),
      home: HomePage(),
      navigatorObservers: [routeObserver],
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomePage.routeName:
            return MaterialPageRoute(builder: (_) => HomePage());
          case SearchPage.routeName:
            return CupertinoPageRoute(builder: (_) => SearchPage());
          case TopRatedPage.routeName:
            return CupertinoPageRoute(builder: (_) => TopRatedPage());
          case AiringTodayPage.routeName:
            return CupertinoPageRoute(builder: (_) => AiringTodayPage());
          case NewReleasePage.routeName:
            return CupertinoPageRoute(builder: (_) => NewReleasePage());
          case DetailPage.routeName:
            return CupertinoPageRoute(builder: (_) => DetailPage());
          case WatchlistPage.routeName:
            return CupertinoPageRoute(builder: (_) => WatchlistPage());
          //     case PopularMoviesPage.ROUTE_NAME:
          //       return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
          //     case TopRatedMoviesPage.ROUTE_NAME:
          //       return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
          //     case MovieDetailPage.ROUTE_NAME:
          //       final id = settings.arguments as int;
          //       return MaterialPageRoute(
          //         builder: (_) => MovieDetailPage(id: id),
          //         settings: settings,
          //       );
          //     case SearchPage.ROUTE_NAME:
          //       return CupertinoPageRoute(builder: (_) => SearchPage());
          //     case WatchlistMoviesPage.ROUTE_NAME:
          //       return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
          //     case AboutPage.ROUTE_NAME:
          //       return MaterialPageRoute(builder: (_) => AboutPage());
          //     default:
          //       return MaterialPageRoute(builder: (_) {
          //         return Scaffold(
          //           body: Center(
          //             child: Text('Page not found :('),
          //           ),
          //         );
          //       });
        }
      },
    );
  }
}
