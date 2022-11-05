part of 'cloud_store_cubit.dart';

class CloudStoreState extends Equatable {
  CloudStoreState();

  @override
  List<Object> get props => [];
}

class RestingState extends CloudStoreState {}

class MakingRequestState extends CloudStoreState {}

class LoginState extends CloudStoreState {
  User user;
  LoginState(this.user);
  @override
  List<Object> get props => [];
}

class FailToLoginState extends CloudStoreState {}
