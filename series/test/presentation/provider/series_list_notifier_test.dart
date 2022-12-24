import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_on_air_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/presentation/provider/series_list_notifier.dart';

import '../../dummy_data/dummy_object.dart';
import 'series_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnAirSeries, GetPopularSeries, GetTopRatedSeries])
void main() {
  late SeriesListNotifier provider;
  late MockGetOnAirSeries mockGetOnAirSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirSeries = MockGetOnAirSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    provider = SeriesListNotifier(
      getOnAirSeries: mockGetOnAirSeries,
      getPopularSeries: mockGetPopularSeries,
      getTopRatedSeries: mockGetTopRatedSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('on air series', () {
    test('initialState should be Empty', () {
      expect(provider.onAirState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnAirSeries.execute())
          .thenAnswer((_) async => Right(seriesList));
      // act
      provider.fetchOnAirSeries();
      // assert
      verify(mockGetOnAirSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnAirSeries.execute())
          .thenAnswer((_) async => Right(seriesList));
      // act
      provider.fetchOnAirSeries();
      // assert
      expect(provider.onAirState, RequestState.loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetOnAirSeries.execute())
          .thenAnswer((_) async => Right(seriesList));
      // act
      await provider.fetchOnAirSeries();
      // assert
      expect(provider.onAirState, RequestState.loaded);
      expect(provider.onAirSeries, seriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnAirSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnAirSeries();
      // assert
      expect(provider.onAirState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(seriesList));
      // act
      provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(seriesList));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.loaded);
      expect(provider.popularSeries, seriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(seriesList));
      // act
      provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(seriesList));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.loaded);
      expect(provider.topRatedSeries, seriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
