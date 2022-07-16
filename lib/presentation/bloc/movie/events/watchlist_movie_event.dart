import 'package:equatable/equatable.dart';
import '../../../../domain/entities/movie_detail.dart';

abstract class WatchlistMovieEvent extends Equatable {}

class OnWatchlistMovieCalled extends WatchlistMovieEvent {
  @override
  List<Object?> get props => [];
}

class FetchWatchlist extends WatchlistMovieEvent {
  final int id;
  FetchWatchlist(this.id);
  @override
  List<Object?> get props => [id];
}

class AddMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;
  AddMovie(this.movieDetail);
  @override
  List<Object?> get props => [MovieDetail];
}

class RemoveMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;
  RemoveMovie(this.movieDetail);
  @override
  List<Object?> get props => [MovieDetail];
}
