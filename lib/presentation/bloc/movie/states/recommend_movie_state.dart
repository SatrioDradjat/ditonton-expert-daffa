import 'package:equatable/equatable.dart';
import '../../../../domain/entities/movie.dart';

abstract class RecommendationMovieState extends Equatable {}

class RecommendationMovieEmpty extends RecommendationMovieState {
  @override
  List<Object?> get props => [];
}

class RecommendationMovieLoading extends RecommendationMovieState {
  @override
  List<Object?> get props => [];
}

class RecommendationMovieHasData extends RecommendationMovieState {
  final List<Movie> result;
  RecommendationMovieHasData(this.result);
  @override
  List<Object?> get props => [result];
}

class RecommendationMovieError extends RecommendationMovieState {
  final String message;
  RecommendationMovieError(this.message);
  @override
  List<Object?> get props => [message];
}
