import 'package:ditonton/presentation/bloc/series/states/popular_series_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/series/blocs/popular_series_bloc.dart';
import '../../bloc/series/events/popular_series_event.dart';
import '../../widgets/series_card_list.dart';

class PopularSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popularSeries';

  @override
  _PopularSeriesPageState createState() => _PopularSeriesPageState();
}

class _PopularSeriesPageState extends State<PopularSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularSeriesBloc>().add(OnPopularSeriesCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
          builder: (context, state) {
            if (state is PopularSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularSeriesHasData) {
              final fetchPopular = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final popularList = fetchPopular[index];
                  return SeriesCard(popularList);
                },
                itemCount: fetchPopular.length,
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
