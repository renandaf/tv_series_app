import 'package:tv_series_app/data/models/genre_model.dart';
import 'package:tv_series_app/data/models/movie_table.dart';
import 'package:tv_series_app/data/models/series_detail_model.dart';
import 'package:tv_series_app/data/models/series_model.dart';
import 'package:tv_series_app/data/models/watchlist_model.dart';
import 'package:tv_series_app/domain/entities/detail.dart';
import 'package:tv_series_app/domain/entities/genre.dart';
import 'package:tv_series_app/domain/entities/series.dart';
import 'package:tv_series_app/domain/entities/movie.dart';
import 'package:tv_series_app/domain/entities/movie_detail.dart';

const seriesTable = SeriesTable(
    id: 1,
    title: "title",
    posterPath: "posterPath",
    voteAverage: 1,
    overview: "overview");

final seriesMap = {
  'id': 1,
  'title': "title",
  'posterPath': "posterPath",
  'voteAverage': 1.toDouble(),
  'overview': "overview"
};

final watchlist = Detail.watchlist(
    id: 1,
    name: "title",
    posterPath: "posterPath",
    voteAverage: 1,
    overview: "overview");

const seriesModel = SeriesModel(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: ["US"],
    genreIds: [18, 9648],
    originalLanguage: "en",
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars");

const series = Series(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: ["US"],
    genreIds: [18, 9648],
    originalLanguage: "en",
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars");

final seriesDetail = SeriesDetail(
    backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
    episodeRunTime: const [60],
    firstAirDate: DateTime(2011 - 04 - 17),
    genres: genresModel,
    homepage: "http://www.hbo.com/game-of-thrones",
    id: 1399,
    inProduction: false,
    languages: const ["en"],
    lastAirDate: DateTime(2019 - 05 - 19),
    name: "Game of Thrones",
    nextEpisodeToAir: null,
    numberOfEpisodes: 73,
    numberOfSeasons: 8,
    originCountry: const ["US"],
    originalLanguage: "en",
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 369.594,
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
    status: "Ended",
    tagline: "Winter Is Coming",
    type: "Scripted",
    voteAverage: 8.3,
    voteCount: 11504);

final detail = Detail(
    backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
    episodeRunTime: const [60],
    firstAirDate: DateTime(2011 - 04 - 17),
    genres: genres,
    homepage: "http://www.hbo.com/game-of-thrones",
    id: 1399,
    inProduction: false,
    languages: const ["en"],
    lastAirDate: DateTime(2019 - 05 - 19),
    name: "Game of Thrones",
    nextEpisodeToAir: null,
    numberOfEpisodes: 73,
    numberOfSeasons: 8,
    originCountry: const ["US"],
    originalLanguage: "en",
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 369.594,
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
    status: "Ended",
    tagline: "Winter Is Coming",
    type: "Scripted",
    voteAverage: 8.3,
    voteCount: 11504);

final genres = <Genre>[
  const Genre(id: 10765, name: "Sci-Fi & Fantasy"),
  const Genre(id: 18, name: "Drama"),
  const Genre(id: 10759, name: "Action & Adventure"),
  const Genre(id: 9648, name: "Mystery")
];

final genresModel = <GenreModel>[
  const GenreModel(id: 10765, name: "Sci-Fi & Fantasy"),
  const GenreModel(id: 18, name: "Drama"),
  const GenreModel(id: 10759, name: "Action & Adventure"),
  const GenreModel(id: 9648, name: "Mystery")
];

final seriesModelList = <SeriesModel>[seriesModel];
final seriesList = <Series>[series];
final seriesList5 = <Series>[series, series, series, series, series];
final tSeries = <Series>[];
final detailList = <Detail>[];

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
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
