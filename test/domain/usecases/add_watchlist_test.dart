import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_app/domain/usecases/add_watchlist.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SaveWatchlist(mockSeriesRepository);
  });

  test('should save series to the repository', () async {
    // arrange
    when(mockSeriesRepository.addWatchlist(detail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(detail);
    // assert
    verify(mockSeriesRepository.addWatchlist(detail));
    expect(result, const Right('Added to Watchlist'));
  });
}
