import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_app/data/models/series_model.dart';
import 'package:tv_series_app/data/models/series_response.dart';

import '../../json_reader.dart';

void main() {
  const seriesModel = SeriesModel(
      posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
      popularity: 47.432451,
      id: 31917,
      backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
      voteAverage: 5.04,
      overview:
          "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
      firstAirDate: "2010-06-08",
      originCountry: ["US"],
      genreIds: [18, 9648],
      originalLanguage: "en",
      name: "Pretty Little Liars",
      originalName: "Pretty Little Liars");

  final tSeriesResponseModel =
      const SeriesResponse(seriesList: <SeriesModel>[seriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/response.json'));
      // act
      final result = SeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'backdrop_path': '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
            'first_air_date': '2010-06-08',
            'id': 31917,
            'name': 'Pretty Little Liars',
            'origin_country': ['US'],
            'original_language': 'en',
            'original_name': 'Pretty Little Liars',
            'overview':
                'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name "A" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
            'popularity': 47.432451,
            'poster_path': '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
            'vote_average': 5.04
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
