import 'package:equatable/equatable.dart';
import '../../../../domain/entities/movie_detail.dart';

abstract class DetailMovieState extends Equatable {}

class DetailMovieEmpty extends DetailMovieState {
  @override
  List<Object?> get props => [];
}

class DetailMovieLoading extends DetailMovieState {
  @override
  List<Object?> get props => [];
}

class DetailMovieHasData extends DetailMovieState {
  final MovieDetail result;
  DetailMovieHasData(this.result);
  @override
  List<Object?> get props => [result];
}

class DetailMovieError extends DetailMovieState {
  final String message;
  DetailMovieError(this.message);
  @override
  List<Object?> get props => [message];
}
