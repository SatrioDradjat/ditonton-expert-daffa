
import 'package:ditonton/domain/repositories/series_repository.dart';

class GetWactchlistStatSeries {
  final SeriesRepository repository;
  GetWactchlistStatSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}