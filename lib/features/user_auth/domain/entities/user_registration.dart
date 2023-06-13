// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserRegistration extends Equatable {
  final String password;
  final String email;
  final String firstName;
  final String lastName;
  final String? image;

  const UserRegistration({
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.image,
  });
  @override
  List<Object> get props {
    return [
      email,
      firstName,
      lastName,
    ];
  }
}
