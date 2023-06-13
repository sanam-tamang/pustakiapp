import 'package:dartz/dartz.dart';
import 'package:pustakiapp/core/data/model/user_model.dart';
import 'package:pustakiapp/core/error/failure.dart';

abstract class UserDetailRepository {
  Future<Either<Failure, UserModel>> userDetail(String accessToken);
}
