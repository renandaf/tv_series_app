import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tv_series_app/data/datasource/db/database_helper.dart';
import 'package:tv_series_app/data/datasource/movie_local_data_source.dart';
import 'package:tv_series_app/data/datasource/movie_remote_data_source.dart';
import 'package:tv_series_app/data/datasource/series_api_datasource.dart';
import 'package:tv_series_app/data/datasource/series_local_datasource.dart';
import 'package:tv_series_app/domain/repositories/movie_repository.dart';
import 'package:tv_series_app/domain/repositories/series_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  SeriesRepository,
  SeriesAPI,
  SeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
