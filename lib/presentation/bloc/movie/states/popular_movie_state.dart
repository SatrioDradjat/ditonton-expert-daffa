import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie.dart';

abstract class PopularMovieState extends Equatable {}

class PopularMovieEmpty extends PopularMovieState {
  @override
  List<Object?> get props => [];
}

class PopularMovieLoading extends PopularMovieState {
  @override
  List<Object?> get props => [];
}

class PopularMovieHasData extends PopularMovieState {
  final List<Movie> result;
  PopularMovieHasData(this.result);
  @override
  List<Object?> get props => [result];
}

class PopularMovieError extends PopularMovieState {
  final String message;
  PopularMovieError(this.message);
  @override
  List<Object?> get props => [message];
}
