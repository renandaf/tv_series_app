import 'package:flutter/material.dart';
import 'package:tv_series_app/common/constants.dart';
import 'package:tv_series_app/presentation/pages/home_movies_page.dart';
import 'package:tv_series_app/presentation/pages/now_playing_movie_page.dart';
import 'package:tv_series_app/presentation/pages/on_air_series_page.dart';
import 'package:tv_series_app/presentation/pages/home_series_page.dart';
import 'package:tv_series_app/presentation/pages/popular_movie_page.dart';
import 'package:tv_series_app/presentation/pages/popular_series_page.dart';
import 'package:tv_series_app/presentation/pages/top_rated_movie_page.dart';
import 'package:tv_series_app/presentation/pages/top_rated_series_page.dart';
import 'package:tv_series_app/presentation/pages/watchlist_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                Navigator.pushReplacementNamed(context, PopularPage.routeName);
              },
            ),
            ListTile(
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
                Navigator.pushReplacementNamed(context, TopRatedPage.routeName);
              },
            ),
            const Divider(),
            ListTile(
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
    );
  }
}
