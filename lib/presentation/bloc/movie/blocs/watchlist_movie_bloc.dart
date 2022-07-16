// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_watchlist_movies.dart';
import '../../../../domain/usecases/get_watchlist_status.dart';
import '../../../../domain/usecases/remove_watchlist.dart';
import '../../../../domain/usecases/save_watchlist.dart';
import '../events/watchlist_movie_event.dart';
import '../states/watchlist_movie_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;
  WatchlistMoviesBloc(
    this._getWatchListStatus,
    this._getWatchlistMovies,
    this._removeWatchlist,
    this._saveWatchlist,
  ) : super(WatchlistMovieEmpty()) {
    on<OnWatchlistMovieCalled>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
          (failure) => emit(WatchlistMovieError(failure.message)),
          (data) => data.isNotEmpty
              ? emit(WatchlistMovieHasData(data))
              : emit(WatchlistMovieEmpty()));
    });

    on<FetchWatchlist>((event, emit) async {
      final id = event.id;
      emit(WatchlistMovieLoading());
      final result = await _getWatchListStatus.execute(id);

      emit(MovieIsAdded(result));
    });

    on<AddMovie>((event, emit) async {
      final Movies = event.movieDetail;
      final result = await _saveWatchlist.execute(Movies);

      result.fold((failure) => emit(WatchlistMovieError(failure.message)),
          (message) => emit(WatchlistMovieMessage(message)));
    });

    on<RemoveMovie>((event, emit) async {
      final Movies = event.movieDetail;
      final result = await _removeWatchlist.execute(Movies);

      result.fold((failure) => emit(WatchlistMovieError(failure.message)),
          (message) => emit(WatchlistMovieMessage(message)));
    });
  }
}
