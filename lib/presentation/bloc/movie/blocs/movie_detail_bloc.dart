import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/get_movie_detail.dart';
import '../events/movie_detail_event.dart';
import '../states/movie_detail_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getMovieDetail;
  DetailMovieBloc(this._getMovieDetail) : super(DetailMovieEmpty()) {
    on<OnDetailMovieCalled>((event, emit) async {
      final id = event.id;
      emit(DetailMovieLoading());
      final result = await _getMovieDetail.execute(id);

      result.fold((failure) {
        emit(DetailMovieError(failure.message));
      }, (data) {
        emit(DetailMovieHasData(data));
      });
    });
  }
}
