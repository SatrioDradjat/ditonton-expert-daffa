import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../../entities/tvSeries/series_detail.dart';
import '../../repositories/series_repository.dart';

class RemoveWatchlistSeries {
  final SeriesRepository repository;
  RemoveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail tvSeries) {
    return repository.removeWatchlist(tvSeries);
  }
}