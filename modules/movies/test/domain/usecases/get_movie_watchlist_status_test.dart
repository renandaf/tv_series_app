import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_movie_watchlist_status.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetMovieWatchListStatus usecase;
  late MockMovieRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockMovieRepository();
    usecase = GetMovieWatchListStatus(mockSeriesRepository);
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
