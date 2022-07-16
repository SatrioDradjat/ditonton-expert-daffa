import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_recomendation_series.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_series_detail.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/tvSeries/get_watchlist_series_stat.dart';
import 'package:ditonton/domain/usecases/tvSeries/search_series.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/recommend_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/blocs/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search/movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search/series/search_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/detail_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/on_the_air_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/popular_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/recommend_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/top_rated_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series/blocs/watchlist_series_bloc.dart';
import 'package:ditonton/ssl_pinning/ssl_pinning.dart';

import 'package:get_it/get_it.dart';
import 'data/datasources/datasource_movie/db/database_helper.dart';
import 'data/datasources/datasource_movie/movie_local_data_source.dart';
import 'data/datasources/datasource_movie/movie_remote_data_source.dart';
import 'data/datasources/datasource_tvseries/db/database_helper_series.dart';
import 'data/datasources/datasource_tvseries/series_local_data_source.dart';
import 'data/datasources/datasource_tvseries/series_remote_data_source.dart';
import 'data/repositories/series_repository_impl.dart';
import 'domain/repositories/series_repository.dart';
import 'domain/usecases/tvSeries/get_on_the_air_series.dart';
import 'domain/usecases/tvSeries/get_popular_series.dart';
import 'domain/usecases/tvSeries/get_top_rated_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart'
    as moviesRemoveWatchlist;
import 'package:ditonton/domain/usecases/save_watchlist.dart'
    as moviesSaveWatchlist;
import 'package:ditonton/domain/usecases/tvSeries/remove_watchlist_series.dart'
    as tvSeriesRemoveWatchlist;
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_series.dart'
    as tvSeriesSaveWatchlist;

import 'domain/usecases/tvSeries/save_watchlist_series.dart';

final locator = GetIt.instance;

void init() {
  // Bloc movie
  locator.registerFactory(
    () => DetailMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // Bloc series
  locator.registerFactory(
    () => DetailSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SeriesSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistSeriesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(
      () => moviesSaveWatchlist.SaveWatchlist(locator()));
  locator.registerLazySingleton(
      () => moviesRemoveWatchlist.RemoveWatchlist(locator()));

  // use case series
  locator.registerLazySingleton(() => GetOnTheAirSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetDetailSeries(locator()));
  locator.registerLazySingleton(() => GetRecommendationsSeries(locator()));
  locator.registerLazySingleton(() => SearchWatchlistSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetWactchlistStatSeries(locator()));
  locator.registerLazySingleton(
      () => tvSeriesSaveWatchlist.SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(
      () => tvSeriesRemoveWatchlist.RemoveWatchlistSeries(locator()));

  // repository movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  // repository series
  locator.registerLazySingleton<SeriesRepository>(
    () => SeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources movie
  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperSeries>(
      () => DatabaseHelperSeries());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
