// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? image;
  final bool? isAdmin;
  final bool? isActive;
  final String? lastLogin;
  final String? createdAt;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.image,
    this.isAdmin,
    this.isActive,
    this.lastLogin,
    this.createdAt,
  });
  @override
  List<Object> get props {
    return [
      id,
      email,
      firstName,
      lastName,
    ];
  }
}
