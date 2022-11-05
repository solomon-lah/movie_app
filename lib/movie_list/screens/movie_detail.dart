import 'dart:ui';

import 'package:briskit_assignment/movie_list/bloc/internet_cubit/internet_connection_cubit.dart';
import 'package:briskit_assignment/movie_list/bloc/movie-detail-bloc/cubit/movie_detail_cubit.dart';
import 'package:briskit_assignment/movie_list/constants.dart';
import 'package:briskit_assignment/movie_list/models.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

class MovieDetailScreen extends StatefulWidget {
  MovieDetailParams movieDetailParams;

  MovieDetailScreen({required this.movieDetailParams, Key? key})
      : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<MovieDetailCubit>(context)
        .get_movie_detail(widget.movieDetailParams.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
      if (state is FetchingMovieDetailState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GottenMovieDetailState) {
        List<String> images =
            state.movieDetail.images.items.map((e) => e.image).toList();
        if (images.length > 4) {
          images = images.sublist(0, 5);
        }

        return Container(
          color: Colors.white,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                  floating: true,
                  snap: true,
                  foregroundColor: Colors.grey,
                  expandedHeight: 350,
                  title: Text(
                    widget.movieDetailParams.title,
                    style: _movieDetailTextStyle(
                        fontSize: 20, fontColor: Colors.white),
                  ),
                  flexibleSpace:
                      FlexibleSpaceBar(background: Carousel(images))),
              SliverList(
                  delegate: SliverChildListDelegate([
                _movieDetailContainer(
                    content: Text(state.movieDetail.fullTitle,
                        style: _movieDetailTextStyle(fontSize: 20))),
                _movieDetailContainer(
                    content: Text('By ${state.movieDetail.stars}',
                        style: _movieDetailTextStyle(
                            fontColor: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.normal))),
                _movieDetailContainer(
                    content: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: OutlinedButton(
                              onPressed: () {}, child: Icon(Icons.thumb_up)),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: OutlinedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.comment))))
                    ],
                  ),
                )),
                _movieDetailContainer(
                    content: Text(
                  state.movieDetail.plot,
                  style: _movieDetailTextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal),
                )),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: state.movieDetail.actorList
                        .map((e) => Container(
                              color: Colors.grey,
                              margin: EdgeInsets.all(8.0),
                              child: Image.network(
                                e.image,
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                            ))
                        .toList(),
                  ),
                ),
                _movieDetailContainer(
                    content: Text(
                  'Directors: ${state.movieDetail.directors}',
                  style: _movieDetailTextStyle(fontSize: 18),
                )),
                _movieDetailContainer(
                    content: Text(
                  'Release Date: ${state.movieDetail.releaseDate}',
                  style: _movieDetailTextStyle(fontSize: 18),
                )),
                _movieDetailContainer(
                    content: Text(
                  'Genre: ${state.movieDetail.genres}',
                  style: _movieDetailTextStyle(fontSize: 18),
                )),
                _movieDetailContainer(
                    content: Text(
                  'Countries: ${state.movieDetail.countries}',
                  style: _movieDetailTextStyle(fontSize: 18),
                )),
                _movieDetailContainer(
                    content: Text(
                  'Languages: ${state.movieDetail.languages}',
                  style: _movieDetailTextStyle(fontSize: 18),
                )),
                _movieDetailContainer(
                    content: Text(
                  'Writers: ${state.movieDetail.writers}',
                  style: _movieDetailTextStyle(fontSize: 18),
                ))
              ])),
            ],
          ),
        );
      }
      return Center(
        child: Text('Loading'),
      );
    }));
  }

  Container _movieDetailContainer({required Widget content}) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(5.0),
        child: content,
      );

  TextStyle _movieDetailTextStyle(
          {FontWeight fontWeight = FontWeight.bold,
          double fontSize = 25,
          Color fontColor = Colors.black}) =>
      TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: fontColor,
          decoration: TextDecoration.none);
}

class Carousel extends StatefulWidget {
  List<String> itemList;
  Carousel(this.itemList);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: size.height,
      width: size.width,
      child: Column(children: [
        Container(
          child: Flexible(
            flex: 9,
            child: PageView.builder(
              itemBuilder: ((context, index) => Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(color: Colors.black)),
                    child:
                        Image.network(widget.itemList[index], fit: BoxFit.fill),
                  )),
              itemCount: widget.itemList.length,
              controller: _controller,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(8),
            child: SmoothPageIndicator(
                controller: _controller, // PageController
                count: widget.itemList.length,
                effect: WormEffect(
                  activeDotColor: Colors.black,
                ), // your preferred effect
                onDotClicked: (index) {}),
          ),
        )
      ], mainAxisSize: MainAxisSize.max),
    );
    ;
  }
}

class TrailerPlayer extends StatefulWidget {
  String trailer_url;
  TrailerPlayer({required this.trailer_url, Key? key}) : super(key: key);

  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.trailer_url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.trailer_url);
    return Center(
        child: _videoPlayerController.value.isInitialized
            ? Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                  Center(
                      child: GestureDetector(
                          onTap: _playPause,
                          child: Icon(
                            Icons.play_circle,
                            size: 40.0,
                          )))
                ],
                fit: StackFit.loose,
              )
            : Container(
                child: CircularProgressIndicator(color: Colors.black),
              ));
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  _playPause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
  }
}
