part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoadingState extends UserProfileState {}

class UserProfileLoadedState extends UserProfileState {
  final UserModel userModel;
  const UserProfileLoadedState({
    required this.userModel,
  });

  @override
  List<Object> get props => [userModel];
}

class UserProfileErrorState extends UserProfileState {
  final String errorMessage;
  const UserProfileErrorState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
