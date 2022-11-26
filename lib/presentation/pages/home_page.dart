import 'package:flutter/material.dart';
import 'package:tv_series_app/common/constants.dart';
import 'package:tv_series_app/pages/search_page.dart';
import 'package:tv_series_app/widgets/card_movie.dart';
import 'package:tv_series_app/widgets/drawer.dart';
import 'package:tv_series_app/widgets/trending_movie_slider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(child: CustomDrawer()),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'TV Series',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending',
                style: kH6,
              ),
              SizedBox(
                height: 20,
              ),
              TrendingMovieSlider(),
              SizedBox(
                height: 20,
              ),
              _buildSubHeading(title: 'New Series', onTap: () {}),
              Container(
                height: 240,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return CardMovie();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _buildSubHeading(title: 'Airing Today', onTap: () {}),
              Container(
                height: 240,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return CardMovie();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _buildSubHeading(title: 'Top Rated', onTap: () {}),
              Container(
                height: 240,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return CardMovie();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kH6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'See More',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
