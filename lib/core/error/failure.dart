// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}



class PasswordFailure extends Failure {
  final String message;
  PasswordFailure({
    required this.message,
  });
  @override
  String toString() {
    return message.toString();
  }
}

class EmailFailure extends Failure {
    final String message;
  EmailFailure({
    required this.message,
  });
  @override
  String toString() {
    return message.toString();
  }
}

class ServerFailure extends Failure {}

class InternetFailure extends Failure {}

class RefreshTokenExpireFailure extends Failure {}

class LoginFailure extends Failure {
   final String message;
  LoginFailure({
    required this.message,
  });
  @override
  String toString() {
    return message.toString();
  }
}


class FileDownloadFailure extends Failure{
  
}