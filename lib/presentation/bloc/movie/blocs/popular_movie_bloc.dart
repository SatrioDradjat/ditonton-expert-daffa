import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/get_popular_movies.dart';
import '../events/popular_movie_event.dart';
import '../states/popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovies;
  PopularMovieBloc(this._getPopularMovies) : super(PopularMovieEmpty()) {
    on<OnPopularMovieCalled>(((event, emit) async {
      emit(PopularMovieLoading());
      final result = await _getPopularMovies.execute();

      result.fold((failure) {
        emit(PopularMovieError(failure.message));
      }, (data) {
        data.isNotEmpty
            ? emit(PopularMovieHasData(data))
            : emit(PopularMovieEmpty());
      });
    }));
  }
}
