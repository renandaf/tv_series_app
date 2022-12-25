import 'dart:convert';
import 'dart:io';
import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:series/data/models/season_detail.dart';
import 'package:series/data/models/series_detail_model.dart';
import 'package:series/data/models/series_model.dart';
import 'package:series/data/models/series_response.dart';
import 'package:series/domain/entities/detail.dart';

abstract class SeriesAPI {
  Future<List<SeriesModel>> getOnAirSeries();
  Future<List<SeriesModel>> getPopularSeries();
  Future<List<SeriesModel>> getTopRatedSeries();
  Future<SeriesDetail> getSeriesDetail(int id);
  Future<List<SeriesModel>> getSeriesRecommendations(int id);
  Future<List<SeriesModel>> searchSeries(String query);
  Future<SeasonDetail> getSeasonDetail(int id, int season);
}

class SeriesAPIImpl implements SeriesAPI {
  static const apiKey = 'api_key=cc351050aaaf5d531ad1a96a72cd9db0';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  SeriesAPIImpl({required this.client});

  @override
  Future<SeasonDetail> getSeasonDetail(int id, int season) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/season/$season?$apiKey'));
    if (response.statusCode == 200) {
      return SeasonDetail.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getOnAirSeries() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeriesDetail> getSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));
    if (response.statusCode == 200) {
      return SeriesDetail.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getSeriesRecommendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getPopularSeries() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getTopRatedSeries() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> searchSeries(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }
}
