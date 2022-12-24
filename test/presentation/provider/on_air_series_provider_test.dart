import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/usecases/get_on_air_series.dart';
import 'package:tv_series_app/presentation/provider/on_air_series_provider.dart';

import '../../dummy_data/dummy_object.dart';
import 'on_air_series_provider_test.mocks.dart';

@GenerateMocks([GetOnAirSeries])
void main() {
  late MockGetOnAirSeries mockGetPopularSeries;
  late OnAirSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularSeries = MockGetOnAirSeries();
    notifier = OnAirSeriesNotifier(mockGetPopularSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularSeries.execute())
        .thenAnswer((_) async => Right(seriesList));
    // act
    notifier.fetchOnAirSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularSeries.execute())
        .thenAnswer((_) async => Right(seriesList));
    // act
    await notifier.fetchOnAirSeries();
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
    await notifier.fetchOnAirSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
