import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:series/series.dart';
import '../pages/watchlist_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  "Menu",
                  style: kH3,
                ),
              ),
              const Divider(),
              ListTile(
                trailing: const Icon(Icons.arrow_drop_down),
                title: Text(
                  'Movies',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, HomePageMovies.routeName);
                },
              ),
              ListTile(
                key: const Key("popular_movie"),
                leading: Icon(
                  Icons.favorite_outline,
                  color: Colors.white.withOpacity(0.9),
                ),
                title: Text(
                  'Popular',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, PopularMoviePage.routeName);
                },
              ),
              ListTile(
                key: const Key("nowplaying_movie"),
                leading: Icon(
                  Icons.today,
                  color: Colors.white.withOpacity(0.9),
                ),
                title: Text(
                  'Now Playing',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, NowPlayingMoviePage.routeName);
                },
              ),
              ListTile(
                key: const Key("toprated_movie"),
                leading: Icon(
                  Icons.star_outline,
                  color: Colors.white.withOpacity(0.9),
                ),
                title: Text(
                  'Top Rated',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, TopRatedMoviePage.routeName);
                },
              ),
              const Divider(),
              ListTile(
                trailing: const Icon(Icons.arrow_drop_down),
                title: Text(
                  'TV Series',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, HomePageSeries.routeName);
                },
              ),
              ListTile(
                key: const Key("popular_series"),
                leading: Icon(
                  Icons.favorite_outline,
                  color: Colors.white.withOpacity(0.9),
                ),
                title: Text(
                  'Popular',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, PopularPage.routeName);
                },
              ),
              ListTile(
                key: const Key("onair_series"),
                leading: Icon(
                  Icons.today,
                  color: Colors.white.withOpacity(0.9),
                ),
                title: Text(
                  'Airing Today',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, OnAirPage.routeName);
                },
              ),
              ListTile(
                key: const Key("toprated_series"),
                leading: Icon(
                  Icons.star_outline,
                  color: Colors.white.withOpacity(0.9),
                ),
                title: Text(
                  'Top Rated',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, TopRatedPage.routeName);
                },
              ),
              const Divider(),
              ListTile(
                key: const Key("watchlist"),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: Text(
                  'Watchlist',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, WatchlistPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
