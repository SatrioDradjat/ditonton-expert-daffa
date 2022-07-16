import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_now_playing_movies.dart';
import '../events/now_playing_movie_event.dart';
import '../states/now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  NowPlayingMovieBloc(this._getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<OnNowPlayingMovie>(((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(NowPlayingMovieError(failure.message));
      }, (data) {
        data.isNotEmpty
            ? emit(NowPlayingMovieHasData(data))
            : emit(NowPlayingMovieEmpty());
      });
    }));
  }
}
