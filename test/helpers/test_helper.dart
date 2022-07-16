import 'package:ditonton/data/datasources/datasource_movie/db/database_helper.dart';
import 'package:ditonton/data/datasources/datasource_movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/datasource_movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/datasource_tvseries/db/database_helper_series.dart';
import 'package:ditonton/data/datasources/datasource_tvseries/series_local_data_source.dart';
import 'package:ditonton/data/datasources/datasource_tvseries/series_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  SeriesRepository,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
  DatabaseHelper,
  DatabaseHelperSeries
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
