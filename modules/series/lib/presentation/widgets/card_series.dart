import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/presentation/pages/detail_series_page.dart';

class CardSeries extends StatelessWidget {
  final Series series;
  final int page;
  const CardSeries(this.series, this.page, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: InkWell(
        onTap: () {
          if (page == 1) {
            Navigator.pushReplacementNamed(
              context,
              DetailPage.routeName,
              arguments: series.id,
            );
          } else {
            Navigator.pushNamed(
              context,
              DetailPage.routeName,
              arguments: series.id,
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              width: 130,
              height: 170,
              child: CachedNetworkImage(
                imageUrl: GetSeriesDetail.posterImage(series.posterPath!),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              series.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: kSub,
            ),
          ],
        ),
      ),
    );
  }
}
