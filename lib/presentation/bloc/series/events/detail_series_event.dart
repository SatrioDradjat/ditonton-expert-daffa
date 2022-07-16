import 'package:equatable/equatable.dart';

abstract class DetailSeriesEvent extends Equatable {}

class OnDetailSeriesCalled extends DetailSeriesEvent {
  final int id;

  OnDetailSeriesCalled(this.id);
  @override
  List<Object?> get props => [id];
}
