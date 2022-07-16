import 'package:equatable/equatable.dart';

abstract class PopularMovieEvent extends Equatable {}

class OnPopularMovieCalled extends PopularMovieEvent {
  @override
  List<Object?> get props => [];
}
