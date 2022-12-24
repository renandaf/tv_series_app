import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/usecases/get_top_rated_series.dart';
import 'package:tv_series_app/presentation/provider/top_rated_series_provider.dart';

import '../../dummy_data/dummy_object.dart';
import 'top_rated_series_provider_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late MockGetTopRatedSeries mockGetPopularSeries;
  late TopRatedSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularSeries = MockGetTopRatedSeries();
    notifier = TopRatedSeriesNotifier(mockGetPopularSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularSeries.execute())
        .thenAnswer((_) async => Right(seriesList));
    // act
    notifier.fetchTopRatedSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularSeries.execute())
        .thenAnswer((_) async => Right(seriesList));
    // act
    await notifier.fetchTopRatedSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.series, seriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularSeries.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
