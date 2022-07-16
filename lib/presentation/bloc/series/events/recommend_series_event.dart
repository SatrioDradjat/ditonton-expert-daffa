import 'package:equatable/equatable.dart';

abstract class RecommendationSeriesEvent extends Equatable {}

class OnSeriesRecommendationsCalled extends RecommendationSeriesEvent {
  final int id;

  OnSeriesRecommendationsCalled(this.id);
  @override
  List<Object?> get props => [id];
}
