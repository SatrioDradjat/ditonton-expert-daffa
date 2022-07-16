// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/bloc/series/states/detail_series_state.dart';
import 'package:ditonton/presentation/bloc/series/states/recommend_series_state.dart';
import 'package:ditonton/presentation/bloc/series/states/watchlist_series_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../common/constants.dart';
import '../../../common/utils.dart';
import '../../../domain/entities/tvSeries/series_detail.dart';
import '../../bloc/series/blocs/detail_series_bloc.dart';
import '../../bloc/series/blocs/recommend_series_bloc.dart';
import '../../bloc/series/blocs/watchlist_series_bloc.dart';
import '../../bloc/series/events/detail_series_event.dart';
import '../../bloc/series/events/recommend_series_event.dart';
import '../../bloc/series/events/watchlist_series_event.dart';

class SeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detailSeries';

  final int id;
  SeriesDetailPage({required this.id});

  @override
  _SeriesDetailPageState createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailSeriesBloc>().add(OnDetailSeriesCalled(widget.id));
      context
          .read<RecommendationSeriesBloc>()
          .add(OnSeriesRecommendationsCalled(widget.id));
      context.read<WatchlistSeriesBloc>().add(FetchWatchlistSeries(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final SeriesAddToWatchlist =
        context.select<WatchlistSeriesBloc, bool>((bloc) {
      if (bloc.state is SeriesIsAdded) {
        return (bloc.state as SeriesIsAdded).isAdded;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<DetailSeriesBloc, DetailSeriesState>(
        builder: (context, state) {
          if (state is DetailSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailSeriesHasData) {
            final series = state.result;
            return SafeArea(
              child: DetailContent(
                series,
                SeriesAddToWatchlist,
              ),
            );
          } else {
            return Text('Failed To Fetch');
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final SeriesDetail detail;
  late bool addContent;
  DetailContent(this.detail, this.addContent);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    void _watchlist() {
      if (!widget.addContent) {
        context.read<WatchlistSeriesBloc>().add(AddSeries(widget.detail));
      } else {
        context.read<WatchlistSeriesBloc>().add(RemoveSeries(widget.detail));
      }

      const AddMessage = 'Series Added to Watchlist';
      const RemoveMessage = 'Series Removed to Watchlist';
      String message = '';
      final state = BlocProvider.of<WatchlistSeriesBloc>(context).state;
      if (state is SeriesIsAdded) {
        final isAdded = state.isAdded;
        message = isAdded == false ? AddMessage : RemoveMessage;
      } else {
        message = !widget.addContent ? AddMessage : RemoveMessage;
      }

      if (message == AddMessage || message == RemoveMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          duration: const Duration(
            seconds: 1,
          ),
        ));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(message),
              );
            });
      }
      setState(() {
        widget.addContent = !widget.addContent;
      });
    }

    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.detail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.detail.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                _watchlist();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.addContent
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              showFormatGenres(widget.detail.genres),
                            ),
                            SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _moreDetails(
                                    'Runtime: ${widget.detail.episodeRunTime.isEmpty ? 'N/A' : showFormatDurationFromList(widget.detail.episodeRunTime)}',
                                  ),
                                  SizedBox(height: 10),
                                  _moreDetails(
                                    'Episode: ${widget.detail.numberOfEpisodes}',
                                  ),
                                  SizedBox(height: 10),
                                  _moreDetails(
                                    'Season: ${widget.detail.numberOfSeasons}',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.detail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.detail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.detail.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            widget.detail.seasons.isNotEmpty
                                ? Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final season =
                                            widget.detail.seasons[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: Stack(
                                              children: [
                                                season.posterPath == null
                                                    ? Container(
                                                        width: 96.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: kDavysGrey,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Image not available',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      )
                                                    : CachedNetworkImage(
                                                        imageUrl:
                                                            'https://image.tmdb.org/t/p/w500${season.posterPath}',
                                                        placeholder:
                                                            (context, url) =>
                                                                Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                Positioned.fill(
                                                  child: Container(
                                                    color: kRichBlack
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: widget.detail.seasons.length,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'Image not available',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),

                            // recommendation
                            BlocBuilder<RecommendationSeriesBloc,
                                RecommendationSeriesState>(
                              builder: (context, state) {
                                if (state is RecommendationSeriesLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is RecommendationSeriesError) {
                                  return Text(state.message);
                                } else if (state
                                    is RecommendationSeriesHasData) {
                                  final showRecommends = state.result;
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final recommendList =
                                            showRecommends[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                SeriesDetailPage.ROUTE_NAME,
                                                arguments: recommendList.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${recommendList.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: showRecommends.length,
                                    ),
                                  );
                                } else if (state is RecommendationSeriesEmpty) {
                                  return Center(
                                    child: Text(
                                      'Series Recommendation is not available',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  Container _moreDetails(data) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kOxfordBlue,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        data,
      ),
    );
  }
}
