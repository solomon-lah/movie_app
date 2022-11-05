part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitialState extends MovieDetailState {}

class FetchingMovieDetailState extends MovieDetailState {}

class GottenMovieDetailState extends MovieDetailState {
  MovieDetail movieDetail;
  GottenMovieDetailState(this.movieDetail);
  @override
  List<Object> get props => [this.movieDetail];
}

class NoInternetMovieDetailState extends MovieDetailState {}

class ErrorInGettingMovieDetailState extends MovieDetailState {}
