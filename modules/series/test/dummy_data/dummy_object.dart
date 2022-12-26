import 'package:core/core.dart';
import 'package:series/data/models/series_detail_model.dart';
import 'package:series/data/models/series_model.dart';
import 'package:series/data/models/watchlist_model.dart';
import 'package:series/domain/entities/detail.dart';
import 'package:series/domain/entities/episode.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/series.dart';

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

const testSeason = Season(
    id: "1",
    airDate: "1",
    episodes: <Episode>[],
    name: "name",
    overview: "overview",
    seasonDetailId: 1,
    posterPath: "posterPath",
    seasonNumber: 1);

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
