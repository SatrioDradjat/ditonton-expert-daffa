import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/tvSeries/get_top_rated_series.dart';
import '../events/top_rated_series_event.dart';
import '../states/top_rated_series_state.dart';

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries _getTopRatedSeries;

  TopRatedSeriesBloc(this._getTopRatedSeries) : super(TopRatedSeriesEmpty()) {
    on<OnSeriesTopRatedCalled>((event, emit) async {
      emit(TopRatedSeriesLoading());
      final result = await _getTopRatedSeries.execute();

      result.fold(
        (failure) {
          emit(TopRatedSeriesError(failure.message));
        },
        (data) => data.isNotEmpty
            ? emit(TopRatedSeriesHasData(data))
            : emit(TopRatedSeriesEmpty()),
      );
    });
  }
}
