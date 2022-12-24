import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/data/datasource/series_local_datasource.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = SeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(seriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(seriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(seriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(seriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('insert watchlist', () {
    test('should return success message when insert from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(seriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(seriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(seriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(seriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Series By Id', () {
    const id = 1;

    test('should return Series Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(id))
          .thenAnswer((_) async => seriesMap);
      // act
      final result = await dataSource.getSeriesById(id);
      // assert
      expect(result, seriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(id)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSeriesById(id);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist series', () {
    test('should return list of SeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSeries())
          .thenAnswer((_) async => [seriesMap]);
      // act
      final result = await dataSource.getWatchlistSeries();
      // assert
      expect(result, [seriesTable]);
    });
  });
}
