import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/data/repositories/series_repository_impl.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SeriesRepositoryImpl repository;
  late MockSeriesAPI mockRemoteDataSource;
  late MockSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockSeriesAPI();
    mockLocalDataSource = MockSeriesLocalDataSource();
    repository = SeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('On Air Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAirSeries())
          .thenAnswer((_) async => seriesModelList);
      // act
      final result = await repository.getOnAirSeries();
      // assert
      verify(mockRemoteDataSource.getOnAirSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAirSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getOnAirSeries();
      // assert
      verify(mockRemoteDataSource.getOnAirSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAirSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnAirSeries();
      // assert
      verify(mockRemoteDataSource.getOnAirSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSeries())
          .thenAnswer((_) async => seriesModelList);
      // act
      final result = await repository.getPopularSeries();
      // assert
      verify(mockRemoteDataSource.getPopularSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularSeries();
      // assert
      verify(mockRemoteDataSource.getPopularSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularSeries();
      // assert
      verify(mockRemoteDataSource.getPopularSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Top Rated Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenAnswer((_) async => seriesModelList);
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Recomended Series', () {
    const id = 1399;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesRecommendations(id))
          .thenAnswer((_) async => seriesModelList);
      // act
      final result = await repository.getSeriesRecommendations(id);
      // assert
      verify(mockRemoteDataSource.getSeriesRecommendations(id));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesRecommendations(id))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSeriesRecommendations(id);
      // assert
      verify(mockRemoteDataSource.getSeriesRecommendations(id));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesRecommendations(id))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeriesRecommendations(id);
      // assert
      verify(mockRemoteDataSource.getSeriesRecommendations(id));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Series Detail', () {
    const id = 1399;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(id))
          .thenAnswer((_) async => seriesDetail);
      // act
      final result = await repository.getSeriesDetail(id);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(id));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      expect(result, equals(Right(detail)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(id))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSeriesDetail(id);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(id));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(id))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeriesDetail(id);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(id));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Series', () {
    const query = "wednesday";
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(query))
          .thenAnswer((_) async => seriesModelList);
      // act
      final result = await repository.searchSeries(query);
      // assert
      verify(mockRemoteDataSource.searchSeries(query));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, seriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(query))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchSeries(query);
      // assert
      verify(mockRemoteDataSource.searchSeries(query));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(query))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchSeries(query);
      // assert
      verify(mockRemoteDataSource.searchSeries(query));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  // group('Insert to Watchlist', () {
  //   test('should return success message when saving successful', () async {
  //     // arrange
  //     when(mockLocalDataSource.insertWatchlist(seriesTable))
  //         .thenAnswer((_) async => 'Added to Watchlist');
  //     // act
  //     final result = await repository.addWatchlist(detail);

  //     // assert
  //     expect(result, Right('Added to Watchlist'));
  //   });

  //   test('should return DatabaseFailure when saving unsuccessful', () async {
  //     // arrange
  //     when(mockLocalDataSource.insertWatchlist(seriesTable))
  //         .thenThrow(DatabaseException('Failed to add watchlist'));
  //     // act
  //     final result = await repository.addWatchlist(detail);

  //     // assert
  //     expect(result, Left(DatabaseFailure('Failed to add watchlist')));
  //   });
  // });

  // group('remove from watchlist', () {
  //   test('should return success message when removing successful', () async {
  //     // arrange
  //     when(mockLocalDataSource.removeWatchlist(seriesTable))
  //         .thenAnswer((_) async => 'Removed from Watchlist');
  //     // act
  //     final result = await repository.removeWatchlist(detail);
  //     // assert
  //     expect(result, Right('Removed from Watchlist'));
  //   });

  //   test('should return DatabaseFailure when removing unsuccessful', () async {
  //     // arrange
  //     when(mockLocalDataSource.removeWatchlist(seriesTable))
  //         .thenThrow(DatabaseException('Failed to remove watchlist'));
  //     // act
  //     final result = await repository.removeWatchlist(detail);
  //     // assert
  //     expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
  //   });
  // });

  group('Is Added To WatchList', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const id = 1;
      when(mockLocalDataSource.getSeriesById(id)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(id);
      // assert
      expect(result, false);
    });
  });

  group('Series Watchlist', () {
    test('should return list of Series from WatchList', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistSeries())
          .thenAnswer((_) async => [seriesTable]);
      // act
      final result = await repository.getWatchlistSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [watchlist]);
    });
  });
}
