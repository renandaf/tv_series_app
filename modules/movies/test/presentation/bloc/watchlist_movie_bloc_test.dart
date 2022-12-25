import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_movie_watchlist_status.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/remove_movie_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/presentation/bloc/movie_bloc.dart';
import 'package:series/domain/usecases/add_watchlist.dart';

import '../../dummy_data/dummy_object.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetMovieWatchListStatus,
  SaveMovieWatchlist,
  RemoveMovieWatchlist
])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetMovieWatchListStatus mockGetMovieWatchListStatus;
  late MockSaveMovieWatchlist mockSaveMovieWatchlist;
  late MockRemoveMovieWatchlist mockRemoveMovieWatchlist;

  setUp(
    () {
      mockGetWatchlistMovies = MockGetWatchlistMovies();
      mockGetMovieWatchListStatus = MockGetMovieWatchListStatus();
      mockSaveMovieWatchlist = MockSaveMovieWatchlist();
      mockRemoveMovieWatchlist = MockRemoveMovieWatchlist();
      movieWatchlistBloc = MovieWatchlistBloc(
          mockGetMovieWatchListStatus,
          mockGetWatchlistMovies,
          mockRemoveMovieWatchlist,
          mockSaveMovieWatchlist);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(movieWatchlistBloc.state, MovieEmpty());
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieListDetail));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnMovieWatchlist()),
    expect: () => <MovieState>[
      MovieLoading(),
      WatchlistMovieHasData(testMovieListDetail),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'emits [Loading, Error] when get watchlist movies is unsuccessful.',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
          (realInvocation) async =>
              const Left(DatabaseFailure("Failed to Get Data")));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnMovieWatchlist()),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError("Failed to Get Data"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'emits [Loading, MovieWatchlistStatus] when status is gotten successfully.',
    build: () {
      when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((realInvocation) async => true);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnMovieWatchlistStatus(testMovieDetail.id!)),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieWatchlistStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetMovieWatchListStatus.execute(testMovieDetail.id));
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'emits [Loading, MovieWatchlistMessage] when add movie to watchlist is successfully.',
    build: () {
      when(mockSaveMovieWatchlist.execute(testMovieDetail)).thenAnswer(
          (realInvocation) async =>
              const Right(MovieWatchlistBloc.watchlistAddSuccessMessage));
      when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((realInvocation) async => true);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnAddMovieWatchlist(testMovieDetail)),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieWatchlistMessage(
          MovieWatchlistBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockSaveMovieWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'emits [Loading, Error] when add movie to watchlist is unsuccessful.',
    build: () {
      when(mockSaveMovieWatchlist.execute(testMovieDetail)).thenAnswer(
          (realInvocation) async => const Left(DatabaseFailure('Failed')));
      when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((realInvocation) async => false);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnAddMovieWatchlist(testMovieDetail)),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Failed'),
    ],
    verify: (bloc) {
      verify(mockSaveMovieWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'emits [Loading, MovieWatchlistMessage] when remove movie from watchlist is successfully.',
    build: () {
      when(mockRemoveMovieWatchlist.execute(testMovieDetail)).thenAnswer(
          (realInvocation) async =>
              const Right(MovieWatchlistBloc.watchlistRemoveSuccessMessage));
      when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((realInvocation) async => false);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnRemoveMovieWatchlist(testMovieDetail)),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieWatchlistMessage(
          MovieWatchlistBloc.watchlistRemoveSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockRemoveMovieWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieState>(
    'emits [Loading, Error] when remove movie from watchlist is unsuccessful.',
    build: () {
      when(mockRemoveMovieWatchlist.execute(testMovieDetail)).thenAnswer(
          (realInvocation) async => const Left(DatabaseFailure('Failed')));
      when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((realInvocation) async => true);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnRemoveMovieWatchlist(testMovieDetail)),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Failed'),
    ],
    verify: (bloc) {
      verify(mockRemoveMovieWatchlist.execute(testMovieDetail));
    },
  );
}
