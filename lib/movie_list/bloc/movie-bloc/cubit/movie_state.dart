part of 'movie_cubit.dart';

class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitialState extends MovieState {}

class FetchingMovieState extends MovieState {}

class GottenMovieState extends MovieState {
  List<Movie> movies;
  GottenMovieState(this.movies);
  @override
  List<Object> get props => [this.movies];
}

class NoInternetState extends MovieState {}

class ErrorInGettingMovieState extends MovieState {}
