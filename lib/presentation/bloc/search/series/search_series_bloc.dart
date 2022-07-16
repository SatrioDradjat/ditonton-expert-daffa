import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../domain/entities/tvSeries/series_disp.dart';
import '../../../../domain/usecases/tvSeries/search_series.dart';
part 'search_series_state.dart';
part 'search_series_event.dart';

EventTransformer<T> seriesDebounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SeriesSearchBloc extends Bloc<SearchEventSeries, SeriesSearchState> {
  final SearchWatchlistSeries _searchWatchlistSeries;

  SeriesSearchBloc(this._searchWatchlistSeries) : super(SeriesSearchEmpty()) {
    on<SeriesQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SeriesSearchLoading());
      final result = await _searchWatchlistSeries.execute(query);

      result.fold(
        (failure) {
          emit(SeriesSearchError(failure.message));
        },
        (data) {
          emit(SeriesSearchHasData(data));
        },
      );
    }, transformer: seriesDebounce(const Duration(milliseconds: 500)));
  }
}
