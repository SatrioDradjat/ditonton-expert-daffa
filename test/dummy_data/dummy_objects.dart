import 'package:ditonton/data/models/movie_model/genre_model.dart';
import 'package:ditonton/data/models/movie_model/movie_table.dart';
import 'package:ditonton/data/models/tvseries_model/season_model.dart';
import 'package:ditonton/data/models/tvseries_model/series_detail_model.dart';
import 'package:ditonton/data/models/tvseries_model/series_model.dart';
import 'package:ditonton/data/models/tvseries_model/series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tvSeries/series_detail.dart';
import 'package:ditonton/domain/entities/tvSeries/series_disp.dart';

final testMovie = Movie(
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

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
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

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testSeries = Series(
    backdropPath: "/n6vVs6z8obNbExdD3QHTr4Utu1Z.jpg",
    firstAirDate: "2019-07-25",
    genreIds: [
      10765,
    ],
    id: 3435045,
    name: "The Boys",
    originCountry: ["us"],
    originalLanguage: "en",
    originalName: "The Boys",
    overview:
        "A group of vigilantes known informally as 'The Boys' set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
    popularity: 4866.719,
    posterPath: "/stTEycfG9928HYGEISBFaG1ngjM.jpg",
    voteAverage: 8.4,
    voteCount: 6319);

final testSeriesList = [testSeries];

final testSeriesModel = SeriesModel(
    backdropPath: "/n6vVs6z8obNbExdD3QHTr4Utu1Z.jpg",
    firstAirDate: "2019-07-25",
    genreIds: [
      10765,
    ],
    id: 3435045,
    name: "The Boys",
    originCountry: ["us"],
    originalLanguage: "en",
    originalName: "The Boys",
    overview:
        "A group of vigilantes known informally as 'The Boys' set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
    popularity: 4866.719,
    posterPath: "/stTEycfG9928HYGEISBFaG1ngjM.jpg",
    voteAverage: 8.4,
    voteCount: 6319);

final testSeriesModelList = <SeriesModel>[testSeriesModel];
final testSeriesModels = testSeriesModel.toEntity();
final testSeriesListModel = <Series>[testSeriesModels];

final testSeriesDetail = SeriesDetail(
    backdropPath: "backdropPath",
    episodeRunTime: [],
    firstAirDate: "firstAirDate",
    genres: [
      Genre(
        id: 1,
        name: "Action & Adventure",
      )
    ],
    id: 1,
    name: "The Boys",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    overview: "overview",
    posterPath: "posterPath",
    voteAverage: 1,
    voteCount: 1,
    seasons: []);

final tSeriesResponse = SeriesDetailResponse(
    backdropPath: '',
    episodeRunTime: [],
    firstAirDate: "firstAirDate",
    genres: [GenreModel(id: 1, name: 'Action & Adventure')],
    homepage: '',
    id: 1,
    name: 'name',
    numberOfEpisodes: 0,
    numberOfSeasons: 0,
    originalLanguage: 'en',
    originalName: 'The Boys',
    overview: 'overview',
    popularity: 4866.719,
    posterPath: 'posterPath',
    seasons: [
      SeasonModels(
          airDate: '2020-09-10',
          episodeCount: 19,
          id: 163277,
          name: "Specials",
          overview: "",
          posterPath: '',
          seasonNumber: 1)
    ],
    status: "Ended",
    tagline: "",
    type: "Scripted",
    voteAverage: 1,
    voteCount: 1);

final testSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testSeriesDetailResponse = tSeriesResponse.toEntity();
final testSeriesTable = tvSeriesTable.fromEntity(testSeriesDetailResponse);
final testSeriesTablelist = <tvSeriesTable>[testSeriesTable];
final testWatchlistSeries = [testSeriesTable.toEntity()];
