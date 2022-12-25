import 'package:core/core.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:series/series.dart';

@GenerateMocks([
  SeriesRepository,
  SeriesAPI,
  SeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
