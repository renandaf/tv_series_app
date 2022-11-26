import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series_app/common/constants.dart';
import 'package:tv_series_app/pages/detail_series_page.dart';

class CardMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              width: 130,
              height: 170,
              child: Image.network(
                "https://www.themoviedb.org/t/p/original/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "Movie Name",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: kSub,
            ),
            // Text(
            //   "Action,Horror",
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            //   style: kTrans,
            // ),
            // RatingBarIndicator(
            //   rating: 4,
            //   itemCount: 5,
            //   itemBuilder: (context, index) => Icon(
            //     Icons.star,
            //     color: kRed,
            //   ),
            //   itemSize: 17,
            // ),
          ],
        ),
      ),
    );
  }
}
