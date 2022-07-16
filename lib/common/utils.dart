import 'package:flutter/widgets.dart';
import '../domain/entities/genre.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

String showFormatGenres(List<Genre> genres) {
  String result = '';
  for (var genre in genres) {
    result += genre.name + ', ';
  }

  if (result.isEmpty) {
    return result;
  }

  return result.substring(0, result.length - 2);
}

String showFormatDurationFromList(List<int> runtimes) {
  return runtimes.map((runtime) => showFormatDuration(runtime)).join(", ");
}

String showFormatDuration(int runtime) {
  final int hours = runtime ~/ 60;
  final int minutes = runtime % 60;

  if (hours > 0) {
    return '${hours}h ${minutes}m';
  } else {
    return '${minutes}m';
  }
}
