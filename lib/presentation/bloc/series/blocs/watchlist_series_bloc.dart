import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/tvSeries/get_watchlist_series.dart';
import '../../../../domain/usecases/tvSeries/get_watchlist_series_stat.dart';
import '../../../../domain/usecases/tvSeries/remove_watchlist_series.dart';
import '../../../../domain/usecases/tvSeries/save_watchlist_series.dart';
import '../events/watchlist_series_event.dart';
import '../states/watchlist_series_state.dart';

class WatchlistSeriesBloc
    extends Bloc<WatchlistSeriesEvent, WatchlistSeriesState> {
  final GetWatchlistSeries _getWatchlistSeries;
  final GetWactchlistStatSeries _getWactchlistStatSeries;
  final RemoveWatchlistSeries _removeWatchlistSeries;
  final SaveWatchlistSeries _saveWatchlistSeries;
  WatchlistSeriesBloc(
    this._getWactchlistStatSeries,
    this._getWatchlistSeries,
    this._removeWatchlistSeries,
    this._saveWatchlistSeries,
  ) : super(WatchlistSeriesEmpty()) {
    on<OnWatchlistSeriesCalled>((event, emit) async {
      emit(WatchlistSeriesLoading());
      final result = await _getWatchlistSeries.execute();

      result.fold(
          (failure) => emit(WatchlistSeriesError(failure.message)),
          (data) => data.isNotEmpty
              ? emit(WatchlistSeriesHasData(data))
              : emit(WatchlistSeriesEmpty()));
    });

    on<FetchWatchlistSeries>((event, emit) async {
      final id = event.id;
      emit(WatchlistSeriesLoading());
      final result = await _getWactchlistStatSeries.execute(id);

      emit(SeriesIsAdded(result));
    });

    on<AddSeries>((event, emit) async {
      final series = event.seriesDetail;
      final result = await _saveWatchlistSeries.execute(series);

      result.fold((failure) => emit(WatchlistSeriesError(failure.message)),
          (message) => emit(WatchlistSeriesMessage(message)));
    });

    on<RemoveSeries>((event, emit) async {
      final series = event.seriesDetail;
      final result = await _removeWatchlistSeries.execute(series);

      result.fold((failure) => emit(WatchlistSeriesError(failure.message)),
          (message) => emit(WatchlistSeriesMessage(message)));
    });
  }
}
