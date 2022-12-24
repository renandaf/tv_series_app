import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:series/domain/entities/detail.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/presentation/pages/detail_series_page.dart';
import 'package:series/presentation/provider/watchlist_provider.dart';
import 'package:sizer/sizer.dart';

class WatchList extends StatelessWidget {
  final Detail series;
  const WatchList(this.series, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: series.id);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            width: 75.sp,
            height: 120,
            child: CachedNetworkImage(
                imageUrl: GetSeriesDetail.posterImage(series.posterPath!),
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                      "assets/default.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.fill,
                    )),
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 170.sp,
                child: Text(
                  series.name!,
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
                    rating: series.voteAverage! / 2.toDouble(),
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
                width: 170.sp,
                child: Text(
                  series.overview == null || series.overview == ""
                      ? "No Overview"
                      : series.overview!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kBody,
                ),
              )
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              IconButton(
                  onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Remove from watchlist', style: kH6),
                          content: Text(
                              'Do you want to remove this from your watchlist?',
                              style: kBody),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: Text(
                                'Cancel',
                                style: kBody,
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await Provider.of<WatchListNotifier>(context,
                                        listen: false)
                                    .removeFromWatchlist(series);
                                Navigator.pop(context, 'Confirm');
                              },
                              child: Text('Confirm', style: kBody),
                            ),
                          ],
                        ),
                      ),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white54,
                    size: 30,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
