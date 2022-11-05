import 'package:bloc/bloc.dart';
import 'package:briskit_assignment/movie_list/providers/internet_connection_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  final InternetConnectionProvider internetConnectionProvider;
  InternetConnectionCubit(this.internetConnectionProvider)
      : super(NoInternetConnectionState()) {
    internetConnectionProvider.streamController.stream
        .listen((ConnectivityResult event) {
      if (event == ConnectivityResult.mobile) {
        emit(ActiveInternetConnectionState());
      } else {
        emit(NoInternetConnectionState());
      }
    });
  }
}
