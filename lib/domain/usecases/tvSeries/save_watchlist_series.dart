import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../../entities/tvSeries/series_detail.dart';
import '../../repositories/series_repository.dart';

class SaveWatchlistSeries {
  final SeriesRepository repository;
  SaveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail tvSeries) {
    return repository.saveWatchlist(tvSeries);
  }
}