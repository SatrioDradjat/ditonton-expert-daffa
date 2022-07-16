import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/datasource_tvseries/db/database_helper_series.dart';
import 'package:ditonton/data/models/tvseries_model/series_table.dart';




abstract class SeriesLocalDataSource {
  Future<String> insertSeriesWatchlist(tvSeriesTable tvSeries);
  Future<String> removeWatchlist(tvSeriesTable tvSeries);
  Future<tvSeriesTable?> getSeriesById(int id);
  Future<List<tvSeriesTable>> getSeriesWatchlist();
}

class SeriesLocalDataSourceImpl implements SeriesLocalDataSource {
  final DatabaseHelperSeries databaseHelper;

  SeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertSeriesWatchlist(tvSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertSeriesWatchlist(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(tvSeriesTable tvSeries) async {
    try {
      await databaseHelper.removeWatchlist(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<tvSeriesTable?> getSeriesById(int id) async {
    final result = await databaseHelper.getSeriesById(id);
    if (result != null) {
      return tvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }
  
  @override
  Future<List<tvSeriesTable>> getSeriesWatchlist() async {
    final result = await databaseHelper.getSeriesWatchlist();
    return result.map((data) => tvSeriesTable.fromMap(data)).toList();
  }
}
