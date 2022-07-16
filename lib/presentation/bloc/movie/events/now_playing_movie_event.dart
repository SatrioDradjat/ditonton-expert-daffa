import 'package:equatable/equatable.dart';

abstract class NowPlayingMovieEvent extends Equatable {}

class OnNowPlayingMovie extends NowPlayingMovieEvent {
  @override
  List<Object?> get props => [];
}
