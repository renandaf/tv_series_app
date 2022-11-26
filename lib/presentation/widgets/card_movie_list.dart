import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series_app/common/constants.dart';

class CardList extends StatelessWidget {
  const CardList({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              width: 100,
              height: 120,
              child: Image.network(
                "https://www.themoviedb.org/t/p/original/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Movie Name (2003)",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kH6,
                ),
                SizedBox(
                  height: 8,
                ),
                RatingBarIndicator(
                  rating: 4,
                  itemCount: 5,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: kYellow,
                  ),
                  itemSize: 18,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Action, Horror",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: kSmall,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Season 3 Episode 5",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: kSmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
