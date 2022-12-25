import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_object.dart';
import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMovieBloc bloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    bloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
  });

  test(
    'initial state should be empty',
    () {
      expect(bloc.state, MovieEmpty());
    },
  );

  blocTest<NowPlayingMovieBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingMovie()),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMovieBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingMovie()),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
