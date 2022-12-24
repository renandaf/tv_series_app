import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_app/common/enum.dart';
import 'package:tv_series_app/common/failure.dart';
import 'package:tv_series_app/domain/entities/movie.dart';
import 'package:tv_series_app/domain/usecases/get_now_playing_movies.dart';
import 'package:tv_series_app/presentation/provider/now_playing_movie_notifier.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMovieNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    notifier = NowPlayingMovieNotifier(mockGetNowPlayingMovies)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.fetchNowPlayingMovies();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.fetchNowPlayingMovies();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movie, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlayingMovies();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
