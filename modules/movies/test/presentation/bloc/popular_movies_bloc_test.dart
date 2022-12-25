import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_object.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc bloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test(
    'initial state should be empty',
    () {
      expect(bloc.state, MovieEmpty());
    },
  );

  blocTest<PopularMovieBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnPopularMovie()),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMovieBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer((realInvocation) async =>
          const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnPopularMovie()),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
