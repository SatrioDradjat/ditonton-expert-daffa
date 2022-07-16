import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvSeries/series_disp.dart';
import '../../../common/failure.dart';
import '../../repositories/series_repository.dart';

class SearchWatchlistSeries {
  final SeriesRepository repository;
  SearchWatchlistSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute(String query) {
    return repository.searchSeries(query);
  }
}