import 'package:equatable/equatable.dart';

abstract class TopRatedSeriesEvent extends Equatable {}

class OnSeriesTopRatedCalled extends TopRatedSeriesEvent {
  @override
  List<Object?> get props => [];
}
