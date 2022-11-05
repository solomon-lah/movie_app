import 'package:briskit_assignment/movie_list/bloc/internet_cubit/internet_connection_cubit.dart';
import 'package:briskit_assignment/movie_list/bloc/movie-bloc/cubit/movie_cubit.dart';
import 'package:briskit_assignment/movie_list/models.dart';
import 'package:briskit_assignment/movie_list/screens/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieList extends StatelessWidget {
  MovieList({Key? key}) : super(key: key);
  late BuildContext _buildContext;
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) {
        return MovieCubit(BlocProvider.of<InternetConnectionCubit>(context));
      },
      child: SafeArea(
        child: Scaffold(
            bottomNavigationBar: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    _buildContext = context;
                    return NavigationBarIconButton(
                        onpressed: home, iconData: Icons.home);
                  }),
                  NavigationBarIconButton(
                      onpressed: () {}, iconData: Icons.navigation),
                  Builder(builder: (context) {
                    _buildContext = context;
                    return NavigationBarIconButton(
                        onpressed: search, iconData: Icons.search);
                  }),
                  NavigationBarIconButton(
                      onpressed: () {}, iconData: Icons.favorite),
                  NavigationBarIconButton(
                      onpressed: () {}, iconData: Icons.notifications),
                ]),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 100.0),
                      child: Text('Explore')),
                  Text('Filter')
                ],
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            body:
                BlocBuilder<MovieCubit, MovieState>(builder: (context, state) {
              if (state is FetchingMovieState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GottenMovieState) {
                return ListView.separated(
                  separatorBuilder: ((context, index) => Divider(
                        thickness: 2.0,
                      )),
                  itemBuilder: (itemBuilder, index) {
                    Movie movie = state.movies[index];
                    return Container(
                      padding: EdgeInsets.all(8.0),
                      height: 200.0,
                      child: Row(
                        children: [
                          Expanded(
                              child: Image.network(
                            movie.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(child: CircularProgressIndicator()),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  movie.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  'Description: ${movie.description}',
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.justify,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    OutlinedButton(
                                        onPressed: () {},
                                        child: Icon(Icons.favorite)),
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/movie_detail',
                                              arguments: MovieDetailParams(
                                                  id: movie.id,
                                                  title: movie.title));
                                        },
                                        child: Icon(Icons.more))
                                  ],
                                )
                              ],
                            ),
                          ))
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                      ),
                    );
                  },
                  itemCount: state.movies.length,
                );
              }
              return Column(
                children: [
                  Text('An Error Occur'),
                  ElevatedButton(
                      onPressed: () {}, child: Text('Click to Reload'))
                ],
              );
            })),
      ),
    );
  }

  void search() {
    showDialog(
        barrierDismissible: false,
        context: _buildContext,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Search Movie'),
              content: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(hintText: 'Movie Name'),
              ),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Search'),
                )
              ],
            )).then((value) {
      if (_textEditingController.text.length != 0) {
        BlocProvider.of<MovieCubit>(_buildContext)
            .search_movies(movie_title: _textEditingController.text);
        _textEditingController.clear();
      }
    });
    //BlocProvider.of<MovieCubit>(_buildContext)
    //    .search_movies(movie_title: 'inception 202010');
  }

  void home() {
    BlocProvider.of<MovieCubit>(_buildContext).get_movies();
  }
}
