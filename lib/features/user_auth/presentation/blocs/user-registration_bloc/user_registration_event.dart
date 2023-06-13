// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_registration_bloc.dart';

abstract class UserRegistrationEvent extends Equatable {
  const UserRegistrationEvent();

  @override
  List<Object> get props => [];
}

class UserRegistrationRegisterEvent extends UserRegistrationEvent {
  final UserRegistrationModel user;
  const UserRegistrationRegisterEvent({
    required this.user,
  });
   @override
  List<Object> get props => [user];
}
