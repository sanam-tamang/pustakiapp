// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserLoginModel extends Equatable {
  final String email;
  final String password;
  const UserLoginModel({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email.trim().toLowerCase(),
      'password': password,
    };
  }

  factory UserLoginModel.fromMap(Map<String, dynamic> map) {
    return UserLoginModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginModel.fromJson(String source) =>
      UserLoginModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
