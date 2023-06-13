// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_login_bloc.dart';

abstract class UserLoginState extends Equatable {
  const UserLoginState();

  @override
  List<Object> get props => [];
}

class UserLoginInitial extends UserLoginState {}

class UserLoginLoadingState extends UserLoginState {}

class UserLoginLoadedState extends UserLoginState {
  final String message;
  const UserLoginLoadedState({
    required this.message,
  });
   @override
  List<Object> get props => [message];
}

class UserLoginFailureState extends UserLoginState {
  final String errorMessage;

  const UserLoginFailureState({required this.errorMessage});
   @override
  List<Object> get props => [errorMessage];
}
