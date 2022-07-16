import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/tvSeries/get_on_the_air_series.dart';
import '../events/on_the_air_series_event.dart';
import '../states/on_the_air_series_state.dart';

class OnTheAirSeriesBloc
    extends Bloc<OnTheAirSeriesEvent, OnTheAirSeriesState> {
  final GetOnTheAirSeries _getOnTheAirSeries;
  OnTheAirSeriesBloc(this._getOnTheAirSeries) : super(OnTheAirSeriesEmpty()) {
    on<OnTheAirSeries>(((event, emit) async {
      emit(OnTheAirSeriesLoading());
      final result = await _getOnTheAirSeries.execute();

      result.fold((failure) {
        emit(OnTheAirSeriesError(failure.message));
      }, (data) {
        emit(OnTheAirSeriesHasData(data));
      });
    }));
  }
}
