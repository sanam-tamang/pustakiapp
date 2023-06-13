import 'package:dartz/dartz.dart';
import 'package:pustakiapp/core/data/model/user_login_model.dart';
import 'package:pustakiapp/core/domain/entities/user.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/user_registration_model.dart';

abstract class UserRepositories {
  Future<Either<Failure, User>> register(UserRegistrationModel user);
  Future<Either<Failure, String>> login(UserLoginModel userLogin);
}
