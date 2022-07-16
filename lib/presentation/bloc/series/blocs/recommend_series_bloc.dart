import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/tvSeries/get_recomendation_series.dart';
import '../events/recommend_series_event.dart';
import '../states/recommend_series_state.dart';

class RecommendationSeriesBloc
    extends Bloc<RecommendationSeriesEvent, RecommendationSeriesState> {
  final GetRecommendationsSeries _getRecommendationsSeries;
  RecommendationSeriesBloc(this._getRecommendationsSeries)
      : super(RecommendationSeriesEmpty()) {
    on<OnSeriesRecommendationsCalled>(((event, emit) async {
      final id = event.id;
      emit(RecommendationSeriesLoading());
      final result = await _getRecommendationsSeries.execute(id);

      result.fold((failure) {
        emit(RecommendationSeriesError(failure.message));
      },
          (data) => data.isNotEmpty
              ? emit(RecommendationSeriesHasData(data))
              : emit(RecommendationSeriesEmpty()));
    }));
  }
}
