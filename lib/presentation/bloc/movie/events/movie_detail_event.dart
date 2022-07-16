import 'package:equatable/equatable.dart';

abstract class DetailMovieEvent extends Equatable {}

class OnDetailMovieCalled extends DetailMovieEvent {
  final int id;

  OnDetailMovieCalled(this.id);
  @override
  List<Object?> get props => [id];
}
