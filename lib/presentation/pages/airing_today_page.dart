import 'package:flutter/material.dart';
import 'package:tv_series_app/common/constants.dart';
import 'package:tv_series_app/presentation/pages/search_page.dart';
import 'package:tv_series_app/presentation/widgets/card_movie_list.dart';
import 'package:tv_series_app/presentation/widgets/drawer.dart';

class AiringTodayPage extends StatelessWidget {
  static const routeName = '/airing_today';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(child: CustomDrawer()),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Airing Today',
          style: kH3,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: Icon(
              Icons.search,
              size: 32,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: CardList(),
          );
        },
      ),
    );
  }
}
