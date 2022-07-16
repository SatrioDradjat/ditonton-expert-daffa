import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/tvSeries/get_series_detail.dart';
import '../events/detail_series_event.dart';
import '../states/detail_series_state.dart';

class DetailSeriesBloc extends Bloc<DetailSeriesEvent, DetailSeriesState> {
  final GetDetailSeries _detailSeries;
  DetailSeriesBloc(this._detailSeries) : super(DetailSeriesEmpty()) {
    on<OnDetailSeriesCalled>((event, emit) async {
      final id = event.id;
      emit(DetailSeriesLoading());
      final result = await _detailSeries.execute(id);

      result.fold((failure) {
        emit(DetailSeriesError(failure.message));
      }, (data) {
        emit(DetailSeriesHasData(data));
      });
    });
  }
}
