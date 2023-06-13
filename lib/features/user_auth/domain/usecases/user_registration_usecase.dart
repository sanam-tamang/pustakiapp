import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/user_registration_model.dart';
import '../repositories/user_auth_repositories.dart';
import '../../../../core/domain/usecase/usecase.dart';
import '../../../../core/domain/entities/user.dart';

class UserRegistrationUsecase
    implements Usecase<User, UserRegistrationModel> {
  final UserRepositories repositories;
  UserRegistrationUsecase({
    required this.repositories,
  });
  @override
  Future<Either<Failure, User>>? call(
      UserRegistrationModel user) async {
    return await repositories.register(user);
  }
}
