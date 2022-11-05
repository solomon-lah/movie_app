import 'package:bloc/bloc.dart';
import 'package:briskit_assignment/movie_list/bloc/internet_cubit/internet_connection_cubit.dart';
import 'package:briskit_assignment/movie_list/models.dart';
import 'package:briskit_assignment/movie_list/providers/api-providers.dart';
import 'package:equatable/equatable.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  InternetConnectionCubit internetConnectionCubit;
  MovieCubit(this.internetConnectionCubit) : super(MovieInitialState()) {
    get_movies();
  }

  void get_movies() async {
    if (internetConnectionCubit.state is ActiveInternetConnectionState) {
      emit(FetchingMovieState());
      List<dynamic> movies_from_imdb_api = await ImdbApi().movies();
      movies_from_imdb_api = movies_from_imdb_api.sublist(0, 51);
      List<Movie> movies =
          movies_from_imdb_api.map((e) => Movie.fromImbdApiJson(e)).toList();
      emit(GottenMovieState(movies));
    } else {
      emit(NoInternetState());
    }
  }

  void search_movies({required String movie_title}) async {
    if (internetConnectionCubit.state is ActiveInternetConnectionState) {
      emit(FetchingMovieState());
      List<dynamic> movies_from_imdb_api =
          await ImdbApi().search_movies(movie_name: movie_title);
      if (movies_from_imdb_api.length > 50) {
        movies_from_imdb_api = movies_from_imdb_api.sublist(0, 51);
      }
      List<Movie> movies = movies_from_imdb_api
          .map((e) => Movie.fromImbdApiSearchJson(e))
          .toList();
      emit(GottenMovieState(movies));
    } else {
      emit(NoInternetState());
    }
  }
}
