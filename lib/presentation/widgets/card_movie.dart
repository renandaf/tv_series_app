import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_app/common/constants.dart';
import 'package:tv_series_app/domain/entities/movie.dart';
import 'package:tv_series_app/domain/usecases/get_movie_detail.dart';
import 'package:tv_series_app/presentation/pages/detail_movie_page.dart';

class CardMovie extends StatelessWidget {
  final Movie movie;
  const CardMovie(this.movie, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailMoviePage.routeName,
            arguments: movie.id,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              width: 130,
              height: 170,
              child: CachedNetworkImage(
                imageUrl: GetMovieDetail.posterImage(movie.posterPath!),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              movie.title!,
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
