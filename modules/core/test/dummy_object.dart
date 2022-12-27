import 'package:core/entities/genre.dart';
import 'package:core/model/genre_model.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:series/domain/entities/detail.dart';

final movieDetailList = [testMovieDetail];
final detailList = [detail];

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

const genreModel = GenreModel(id: 10765, name: "Sci-Fi & Fantasy");
const genre = Genre(id: 10765, name: "Sci-Fi & Fantasy");
