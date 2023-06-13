// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_registration_bloc.dart';

abstract class UserRegistrationState extends Equatable {
  const UserRegistrationState();

  @override
  List<Object> get props => [];
}

class UserRegistrationInitial extends UserRegistrationState {}

class UserRegistrationLoadedState extends UserRegistrationState {
  final User user;
  const UserRegistrationLoadedState({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
class UserRegistrationLoadingState extends UserRegistrationState {}

class UserRegistrationErrorState extends UserRegistrationState {
  final String message;
  const UserRegistrationErrorState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
