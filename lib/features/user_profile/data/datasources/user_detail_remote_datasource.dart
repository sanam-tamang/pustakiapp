// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/data/datasources/local_datasource/token_detail_local_datasource.dart';
import '../../../../core/data/datasources/remote_datasource/ask_token_again_when_expired_remote_datasource.dart';

import '../../../../common/api.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/data/model/user_model.dart';

abstract class UserDetailRemoteDataSource {
  Future<UserModel?> getUserDetail(String accessToken);
}

class UserDetailRemoteDataSourceImpl implements UserDetailRemoteDataSource {
  final http.Client client;
  UserDetailRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<UserModel?> getUserDetail(String accessToken) async {
    final response = await client.get(Uri.parse(userDetailUrl),
        headers: {'authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      final UserModel userModel = UserModel.fromMap(jsonDecode(response.body));
      return userModel;
    } else if (response.statusCode == 401) {
      await askTokenAgainWhenExpired();
      final String? newAccessToken =
          await TokenDetailLocalDataSource.getAccessToken();
      //this method again need to call after new token it gotten
     return getUserDetail(newAccessToken!);
     
    ///TODO: yaha mistake xa yo panii 401 mai aauxa
    } else {
      throw RefreshTokenExpireException();
    }
  }
}
