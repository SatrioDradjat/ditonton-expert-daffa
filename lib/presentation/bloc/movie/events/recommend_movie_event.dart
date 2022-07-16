import 'package:equatable/equatable.dart';

abstract class RecommendationMovieEvent extends Equatable {}

class OnMovieRecommendationsCalled extends RecommendationMovieEvent {
  final int id;
  OnMovieRecommendationsCalled(this.id);
  @override
  List<Object?> get props => [];
}
