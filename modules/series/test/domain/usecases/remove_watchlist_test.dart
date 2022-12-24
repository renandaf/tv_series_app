import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/remove_watchlist.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = RemoveWatchlist(mockSeriesRepository);
  });

  test('should remove series to the repository', () async {
    // arrange
    when(mockSeriesRepository.removeWatchlist(detail))
        .thenAnswer((_) async => const Right('Removed from Watchlist'));
    // act
    final result = await usecase.execute(detail);
    // assert
    verify(mockSeriesRepository.removeWatchlist(detail));
    expect(result, const Right('Removed from Watchlist'));
  });
}
