import 'package:dartz/dartz.dart';
import 'package:pustakiapp/core/error/exception.dart';
import '../datasources/user_detail_remote_datasource.dart'
    show UserDetailRemoteDataSource;
import '../../../../core/network/internet_connection_checker.dart';

import '../../../../core/data/model/user_model.dart';
import '../../domain/repositories/user_detail_repository.dart';
import '../../../../core/error/failure.dart';

class UserDetailRepositoryImpl implements UserDetailRepository {
  final UserDetailRemoteDataSource _remote;
  final InternetConnectionChecker _internet;
  UserDetailRepositoryImpl(
      {required UserDetailRemoteDataSource remote,
      required InternetConnectionChecker internet})
      : _remote = remote,
        _internet = internet;
  @override
  Future<Either<Failure, UserModel>> userDetail(String accessToken) async {
    if (await _internet.isConnected) {
      try {
        final UserModel? userModel = await _remote.getUserDetail(accessToken);
       return  userModel == null ? Left(ServerFailure()) : 
         Right(userModel);
      } on RefreshTokenExpireException {
        return Left(RefreshTokenExpireFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
