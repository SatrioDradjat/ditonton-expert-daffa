import 'package:equatable/equatable.dart';

abstract class PopularSeriesEvent extends Equatable {}

class OnPopularSeriesCalled extends PopularSeriesEvent {
  @override
  List<Object?> get props => [];
}
