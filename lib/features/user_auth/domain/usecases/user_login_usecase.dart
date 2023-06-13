import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/data/model/user_login_model.dart';
import '../repositories/user_auth_repositories.dart';

import '../../../../core/domain/usecase/usecase.dart';

class UserLoginUsecase implements Usecase<String, UserLoginModel> {
  final UserRepositories repositories;
  UserLoginUsecase({
    required this.repositories,
  });
  @override
  Future<Either<Failure, String>>? call(UserLoginModel user) async {
    return await repositories.login(user);
  }
}
