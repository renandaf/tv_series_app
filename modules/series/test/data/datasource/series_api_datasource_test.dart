import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:series/data/datasource/series_api_datasource.dart';
import 'package:series/data/models/series_detail_model.dart';
import 'package:series/data/models/series_response.dart';

import '../../helpers/test_helpers.mocks.dart';
import '../../json_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const apiKey = 'api_key=cc351050aaaf5d531ad1a96a72cd9db0';
  const baseUrl = 'https://api.themoviedb.org/3';

  late SeriesAPIImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SeriesAPIImpl(client: mockHttpClient);
  });

  group('get On Air Series', () {
    final tMovieList =
        SeriesResponse.fromJson(json.decode(readJson('dummy_data/on_air.json')))
            .seriesList;

    test('should return list of Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_air.json'), 200, headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getOnAirSeries();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnAirSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Series', () {
    final tMovieList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular.json')))
        .seriesList;

    test('should return list of Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular.json'), 200, headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getPopularSeries();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top rated Series', () {
    final tMovieList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated.json')))
        .seriesList;

    test('should return list of Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/top_rated.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTopRatedSeries();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Detail Series', () {
    const id = 1399;
    final tMovieList =
        SeriesDetail.fromJson(json.decode(readJson('dummy_data/detail.json')));

    test('should return Detail Series when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$id?$apiKey'))).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/detail.json'), 200, headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getSeriesDetail(id);
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$id?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesDetail(id);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Recommendation Series', () {
    const id = 1;
    final tMovieList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/recomendation.json')))
        .seriesList;

    test('should return list of Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/recomendation.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getSeriesRecommendations(id);
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesRecommendations(id);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Recommendation Series', () {
    const query = "a";
    final tMovieList =
        SeriesResponse.fromJson(json.decode(readJson('dummy_data/search.json')))
            .seriesList;

    test('should return list of Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/search.json'), 200, headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.searchSeries(query);
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSeries(query);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
