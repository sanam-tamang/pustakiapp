import 'package:dartz/dartz.dart';
import '../../../../core/data/model/user_model.dart';
import '../repositories/user_detail_repository.dart';
import '../../../../core/domain/usecase/usecase.dart';
import '../../../../core/error/failure.dart';

class UserDetailUsecase implements Usecase<UserModel, String> {
  final UserDetailRepository _repository;

  UserDetailUsecase({required UserDetailRepository repository})
      : _repository = repository;
  @override
  Future<Either<Failure, UserModel>>? call(String accessToken) async {
    return await _repository.userDetail(accessToken);
  }
}
