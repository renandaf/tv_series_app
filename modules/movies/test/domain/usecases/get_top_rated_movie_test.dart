import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetTopRatedMovies usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = GetTopRatedMovies(mockRepository);
  });

  group('GetTopRatedMovies Tests', () {
    group('execute', () {
      test(
          'should get list of series from the repository when execute function is called',
          () async {
        // arrange
        when(mockRepository.getTopRatedMovies())
            .thenAnswer((_) async => Right(testMovieList));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(testMovieList));
      });
    });
  });
}
