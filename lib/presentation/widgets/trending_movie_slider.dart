import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TrendingMovieSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrendingMovieSliderState();
  }
}

class _TrendingMovieSliderState extends State<TrendingMovieSlider> {
  final List<String> images = [
    'https://www.themoviedb.org/t/p/original/f2PVrphK0u81ES256lw3oAZuF3x.jpg',
    'https://www.themoviedb.org/t/p/original/f2PVrphK0u81ES256lw3oAZuF3x.jpg',
    'https://www.themoviedb.org/t/p/original/f2PVrphK0u81ES256lw3oAZuF3x.jpg',
    'https://www.themoviedb.org/t/p/original/f2PVrphK0u81ES256lw3oAZuF3x.jpg',
    'https://www.themoviedb.org/t/p/original/f2PVrphK0u81ES256lw3oAZuF3x.jpg',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider.builder(
      itemCount: images.length,
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, index, realIdx) {
        return Container(
          child: Center(
              child:
                  Image.network(images[index], fit: BoxFit.cover, width: 1000)),
        );
      },
    ));
  }
}
