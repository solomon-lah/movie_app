import 'package:bloc/bloc.dart';
import 'package:briskit_assignment/movie_list/bloc/internet_cubit/internet_connection_cubit.dart';
import 'package:briskit_assignment/movie_list/models.dart';
import 'package:briskit_assignment/movie_list/providers/api-providers.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  InternetConnectionCubit internetConnectionCubit;
  MovieDetailCubit(this.internetConnectionCubit)
      : super(MovieDetailInitialState());
  void get_movie_detail(String id) async {
    if (internetConnectionCubit.state is ActiveInternetConnectionState) {
      emit(FetchingMovieDetailState());
      final movies_detail_from_imdb_api =
          await ImdbApi().get_movie_detail(movie_id: id);
      MovieDetail movieDetail =
          MovieDetail.fromJson(movies_detail_from_imdb_api);
      emit(GottenMovieDetailState(movieDetail));
    } else {
      emit(NoInternetMovieDetailState());
    }
  }
}
