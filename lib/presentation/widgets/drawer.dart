import 'package:flutter/material.dart';
import 'package:tv_series_app/common/constants.dart';
import 'package:tv_series_app/pages/airing_today_page.dart';
import 'package:tv_series_app/pages/home_page.dart';
import 'package:tv_series_app/pages/new_release_page.dart';
import 'package:tv_series_app/pages/top_rated_series_page.dart';
import 'package:tv_series_app/pages/watchlist_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "Menu",
              style: kH3,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              color: Colors.white.withOpacity(0.9),
            ),
            title: Text(
              'Home',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.new_releases_outlined,
              color: Colors.white.withOpacity(0.9),
            ),
            title: Text(
              'Latest Release',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, NewReleasePage.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.today,
              color: Colors.white.withOpacity(0.9),
            ),
            title: Text(
              'Airing Today',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AiringTodayPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.star_outline,
              color: Colors.white.withOpacity(0.9),
            ),
            title: Text(
              'Top Rated',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, TopRatedPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.white.withOpacity(0.9),
            ),
            title: Text(
              'Watchlist',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, WatchlistPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
