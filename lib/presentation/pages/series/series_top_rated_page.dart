import 'package:ditonton/presentation/bloc/series/states/top_rated_series_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/series/blocs/top_rated_series_bloc.dart';
import '../../bloc/series/events/top_rated_series_event.dart';
import '../../widgets/series_card_list.dart';

class TopRatedSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/topRatedSeries';

  @override
  _TopRatedSeriesPageState createState() => _TopRatedSeriesPageState();
}

class _TopRatedSeriesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedSeriesBloc>().add(OnSeriesTopRatedCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
          builder: (context, state) {
            if (state is TopRatedSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedSeriesHasData) {
              final fetchTopRated = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final topRatedList = fetchTopRated[index];
                  return SeriesCard(topRatedList);
                },
                itemCount: fetchTopRated.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('Failed to Fetch'),
              );
            }
          },
        ),
      ),
    );
  }
}
