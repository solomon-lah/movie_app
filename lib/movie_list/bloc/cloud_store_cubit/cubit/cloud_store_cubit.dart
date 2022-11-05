//This cubit stores all login and sign up data state

import 'package:bloc/bloc.dart';
import 'package:briskit_assignment/movie_list/bloc/internet_cubit/internet_connection_cubit.dart';
import 'package:briskit_assignment/movie_list/constants.dart';
import 'package:briskit_assignment/movie_list/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';

part 'cloud_store_state.dart';

class CloudStoreCubit extends Cubit<CloudStoreState> {
  CloudStoreCubit() : super(RestingState());

  void login({required String username, required String password}) async {
    emit(MakingRequestState());
    final _colletions = await FirebaseFirestore.instance
        .collection(Api.FIRESTORE_COLLECTION_NAME)
        .where("username", isEqualTo: username)
        .where('password', isEqualTo: password)
        .get();
    if (_colletions.docs.length == 1) {
      User user = User.formCloudStore(_colletions.docs.first);
      emit(LoginState(user));
    } else {
      emit(FailToLoginState());
    }
  }

  void register({required String username, required String password}) async {
    emit(MakingRequestState());
    final _colletions = await FirebaseFirestore.instance
        .collection(Api.FIRESTORE_COLLECTION_NAME)
        .where("username", isEqualTo: username)
        .get();
    if (_colletions.docs.length == 1) {
      emit(FailToLoginState());
    } else {
      await FirebaseFirestore.instance
          .collection(Api.FIRESTORE_COLLECTION_NAME)
          .add({"username": username, "password": password});
      User user = User(username: username, password: password);
      emit(LoginState(user));
    }
  }
}
