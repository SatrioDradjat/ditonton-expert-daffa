
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvSeries/series_disp.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';

class GetWatchlistSeries {
  final SeriesRepository repository;
  GetWatchlistSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getWatchlistTvSeries();
  }
}