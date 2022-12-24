import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_app/domain/usecases/get_watchlist_status.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetWatchListStatus usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetWatchListStatus(mockSeriesRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockSeriesRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
