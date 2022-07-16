import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_top_rated_movies.dart';
import '../events/top_rated_movie_event.dart';
import '../states/top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super(TopRatedMovieEmpty()) {
    on<OnMovieTopRatedCalled>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(TopRatedMovieError(failure.message));
        },
        (data) => data.isNotEmpty
            ? emit(TopRatedMovieHasData(data))
            : emit(TopRatedMovieEmpty()),
      );
    });
  }
}
