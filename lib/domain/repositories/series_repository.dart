import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvSeries/series_detail.dart';
import 'package:ditonton/domain/entities/tvSeries/series_disp.dart';
import '../../common/failure.dart';


abstract class SeriesRepository {
  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id);
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id);
  Future<Either<Failure, List<Series>>> searchSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(SeriesDetail movie);
  Future<Either<Failure, String>> removeWatchlist(SeriesDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Series>>> getOnTheAirSeries();
  Future<Either<Failure, List<Series>>> getPopularSeries();
  Future<Either<Failure, List<Series>>> getTopRatedSeries();
  Future<Either<Failure, List<Series>>> getWatchlistTvSeries();
}
