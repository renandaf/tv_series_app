import 'package:core/core.dart';
import 'package:movies/data/models/movie_detail_model.dart';
import 'package:movies/data/models/movie_table.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';

const testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];
final testMovie5 = [testMovie, testMovie, testMovie, testMovie, testMovie];
final movieDetalList = [MovieDetail];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: const [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

const detailMovieModel = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    genres: const [GenreModel(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    video: false,
    budget: 1,
    homepage: 'da',
    imdbId: 'ad',
    originalLanguage: 'asd',
    popularity: 2,
    revenue: 1,
    status: 'assf',
    tagline: 'sad');

final testMovieListDetail = [testMovieDetail];

final testWatchlistMovie = MovieDetail.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  voteAverage: 1,
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  voteAverage: 1.toDouble(),
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'voteAverage': 1.toDouble(),
};
