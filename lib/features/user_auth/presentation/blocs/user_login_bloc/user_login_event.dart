part of 'user_login_bloc.dart';

class UserLoginEvent extends Equatable {
  final UserLoginModel userLoginModel;
  const UserLoginEvent({required this.userLoginModel});

  @override
  List<Object> get props => [userLoginModel];
}
