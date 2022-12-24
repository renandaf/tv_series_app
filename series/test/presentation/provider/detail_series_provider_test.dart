import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';
import 'package:series/presentation/provider/detail_series_provider.dart';

import '../../dummy_data/dummy_object.dart';
import 'detail_series_provider_test.mocks.dart';

@GenerateMocks([GetSeriesDetail, GetSeriesRecommendations])
void main() {
  late DetailSeriesNotifier provider;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;

  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    provider = DetailSeriesNotifier(
        getDetailSeries: mockGetSeriesDetail,
        getSeriesRecommendations: mockGetSeriesRecommendations)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });
  const tId = 1;

  void arrangeUsecase() {
    when(mockGetSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(detail));
    when(mockGetSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(seriesList));
  }

  group('Get Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchDetailSeries(tId);
      // assert
      verify(mockGetSeriesDetail.execute(tId));
      verify(mockGetSeriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      provider.fetchDetailSeries(tId);
      // assert
      expect(provider.state, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchDetailSeries(tId);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.series, detail);
      expect(listenerCallCount, 4);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchDetailSeries(tId);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.seriesRecom, seriesList);
    });
  });

  group('Get Movie Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchDetailSeries(tId);
      // assert
      verify(mockGetSeriesRecommendations.execute(tId));
      expect(provider.seriesRecom, seriesList);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(seriesList));
      // act
      await provider.fetchDetailSeries(tId);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
