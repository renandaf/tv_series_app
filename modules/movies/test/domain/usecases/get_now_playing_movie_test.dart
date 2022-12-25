import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetNowPlayingMovies usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = GetNowPlayingMovies(mockRepository);
  });

  group('GetNowPlayingMovies Tests', () {
    group('execute', () {
      test(
          'should get list of series from the repository when execute function is called',
          () async {
        // arrange
        when(mockRepository.getNowPlayingMovies())
            .thenAnswer((_) async => const Right(<Movie>[]));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, const Right(<Movie>[]));
      });
    });
  });
}
