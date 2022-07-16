import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/bloc/series/states/on_the_air_series_state.dart';
import 'package:ditonton/presentation/bloc/series/states/popular_series_state.dart';
import 'package:ditonton/presentation/bloc/series/states/top_rated_series_state.dart';
import 'package:ditonton/presentation/pages/series/series_detail_page.dart';
import 'package:ditonton/presentation/pages/series/series_popular_page.dart';
import 'package:ditonton/presentation/pages/series/series_top_rated_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/constants.dart';
import '../../../domain/entities/tvSeries/series_disp.dart';
import '../../bloc/series/blocs/on_the_air_series_bloc.dart';
import '../../bloc/series/blocs/popular_series_bloc.dart';
import '../../bloc/series/blocs/top_rated_series_bloc.dart';
import '../../bloc/series/events/on_the_air_series_event.dart';
import '../../bloc/series/events/popular_series_event.dart';
import '../../bloc/series/events/top_rated_series_event.dart';

class HomeSeriesPage extends StatefulWidget {
  @override
  _HomeSeriesPageState createState() => _HomeSeriesPageState();
}

class _HomeSeriesPageState extends State<HomeSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OnTheAirSeriesBloc>().add(OnTheAirSeries());
      context.read<PopularSeriesBloc>().add(OnPopularSeriesCalled());
      context.read<TopRatedSeriesBloc>().add(OnSeriesTopRatedCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'On The Air',
              style: kHeading6,
            ),
            BlocBuilder<OnTheAirSeriesBloc, OnTheAirSeriesState>(
                builder: (context, state) {
              if (state is OnTheAirSeriesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is OnTheAirSeriesHasData) {
                final fetchOntheAir = state.result;
                return SeriesList(fetchOntheAir);
              } else {
                return Text('Failed to Fetch');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
                builder: (context, state) {
              if (state is PopularSeriesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularSeriesHasData) {
                final fetchPopular = state.result;
                return SeriesList(fetchPopular);
              } else {
                return Text('Failed to Fetch');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
                builder: (context, state) {
              if (state is TopRatedSeriesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedSeriesHasData) {
                final fetchTopRated = state.result;
                return SeriesList(fetchTopRated);
              } else {
                return Text('Failed to Fetch');
              }
            }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<Series> series;

  SeriesList(this.series);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSerie = series[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailPage.ROUTE_NAME,
                  arguments: tvSerie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSerie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: series.length,
      ),
    );
  }
}
