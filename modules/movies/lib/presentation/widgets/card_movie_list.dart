import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/presentation/pages/detail_movie_page.dart';
import 'package:sizer/sizer.dart';

class MovieList extends StatelessWidget {
  final Movie movie;
  const MovieList(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, DetailMoviePage.routeName,
              arguments: movie.id);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              width: 75.sp,
              height: 120,
              child: CachedNetworkImage(
                imageUrl: GetMovieDetail.posterImage(movie.posterPath!),
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
                    movie.title!,
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
                      rating: movie.voteAverage! / 2.toDouble(),
                      itemCount: 5,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: kYellow,
                      ),
                      itemSize: 18,
                    ),
                    Text(
                      " ${movie.voteAverage} / 10",
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
                    movie.overview!.length < 2
                        ? "No Overview"
                        : movie.overview!,
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
