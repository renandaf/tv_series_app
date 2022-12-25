import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_object.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMovieBloc bloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  test(
    'initial state should be empty',
    () {
      expect(bloc.state, MovieEmpty());
    },
  );

  blocTest<TopRatedMovieBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnTopRatedMovie()),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMovieBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((realInvocation) async =>
          const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnTopRatedMovie()),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
