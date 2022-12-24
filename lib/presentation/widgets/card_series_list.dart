import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:tv_series_app/common/constants.dart';
import 'package:tv_series_app/domain/entities/series.dart';
import 'package:tv_series_app/domain/usecases/get_series_detail.dart';
import 'package:tv_series_app/presentation/pages/detail_series_page.dart';

class SeriesList extends StatelessWidget {
  final Series series;
  const SeriesList(this.series, {super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName,
              arguments: series.id);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              width: 75.sp,
              height: 120,
              child: CachedNetworkImage(
                imageUrl: GetSeriesDetail.posterImage(series.posterPath!),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 190.sp,
                  child: Text(
                    series.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kH6,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: series.voteAverage / 2.toDouble(),
                      itemCount: 5,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: kYellow,
                      ),
                      itemSize: 18,
                    ),
                    Text(
                      " ${series.voteAverage} / 10",
                      style: kSmall,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 190.sp,
                  child: Text(
                    series.overview.length < 2
                        ? "No Overview"
                        : series.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kBody,
                  ),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
