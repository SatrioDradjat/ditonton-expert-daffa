import 'package:equatable/equatable.dart';

abstract class TopRatedMovieEvent extends Equatable {}

class OnMovieTopRatedCalled extends TopRatedMovieEvent {
  @override
  List<Object?> get props => [];
}
