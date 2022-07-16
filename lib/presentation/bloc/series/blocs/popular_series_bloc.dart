import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/tvSeries/get_popular_series.dart';
import '../events/popular_series_event.dart';
import '../states/popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final GetPopularSeries _getPopularSeries;
  PopularSeriesBloc(this._getPopularSeries) : super(PopularSeriesEmpty()) {
    on<OnPopularSeriesCalled>(((event, emit) async {
      emit(PopularSeriesLoading());
      final result = await _getPopularSeries.execute();

      result.fold((failure) {
        emit(PopularSeriesError(failure.message));
      }, (data) {
        emit(PopularSeriesHasData(data));
      });
    }));
  }
}
