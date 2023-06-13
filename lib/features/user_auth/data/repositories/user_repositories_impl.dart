// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/data/model/user_login_model.dart';
import '../../../../core/network/internet_connection_checker.dart';
import '../datasources/user_auth_remote_datasource.dart';
import '../../../../core/domain/entities/user.dart';
import '../../domain/repositories/user_auth_repositories.dart';
import '../models/user_registration_model.dart';

class UserRepositoriesImpl implements UserRepositories {
  final InternetConnectionChecker internetChecker;
  final UserAuthRemoteDataSource remote;
  UserRepositoriesImpl({
    required this.internetChecker,
    required this.remote,
  });
  @override
  Future<Either<Failure, String>> login(UserLoginModel userLogin) async {
    if (await internetChecker.isConnected) {
      try {
        final String message = await remote.login(userLogin);
        return Right(message);
      } on LoginException catch (e) {
        return left(LoginFailure(message: e.toString()));
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(UserRegistrationModel user) async {
    if (await internetChecker.isConnected) {
      try {
        final User registeredUser = await remote.register(user);

        return Right(registeredUser);
      } on ServerException {
        return Left(ServerFailure());
      } on EmailException catch (e) {
        return Left(EmailFailure(message: e.toString()));
      } on PasswordException catch (e) {
        return Left(PasswordFailure(message: e.toString()));
      } catch (e) {
        log(e.toString());
        throw Exception();
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
