import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_movie_recommendations.dart';
import '../events/recommend_movie_event.dart';
import '../states/recommend_movie_state.dart';

class RecommendationMovieBloc
    extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetMovieRecommendations _getMovieRecommendations;
  RecommendationMovieBloc(this._getMovieRecommendations)
      : super(RecommendationMovieEmpty()) {
    on<OnMovieRecommendationsCalled>(((event, emit) async {
      final id = event.id;
      emit(RecommendationMovieLoading());
      final result = await _getMovieRecommendations.execute(id);

      result.fold((failure) {
        emit(RecommendationMovieError(failure.message));
      },
          (data) => data.isNotEmpty
              ? emit(RecommendationMovieHasData(data))
              : emit(RecommendationMovieEmpty()));
    }));
  }
}
