import 'dart:convert';
import 'dart:developer';


import '../../../../common/api.dart';
import '../../../error/exception.dart';
// import '../local_datasource/user_detail_local_datasource.dart';
// import '../../model/user_login_model.dart';
import '../local_datasource/token_detail_local_datasource.dart';
import 'package:http/http.dart' as http;

///after calling this function [askTokenAgainWhenExpired] you need to call currently calling function
///meaning that you also need to call you current function where it is calling
Future<void> askTokenAgainWhenExpired() async {
  //when token is not valid or expired
  final String? refreshToken =
      await TokenDetailLocalDataSource.getRefreshToken();
  try {
    final refreshResponse = await http
        .post(Uri.parse(refreshTokenUrl), body: {'refresh': refreshToken});
    if (refreshResponse.statusCode == 200) {
      final decodedJson = jsonDecode(refreshResponse.body);
      TokenDetailLocalDataSource.saveAccessToken(decodedJson['access']);
    } else {
      //if rereshToken is expired we need to login again
      // final UserLoginModel user =
      //     await UserDetailLocalDataSource.getemailPassword();
      // userLoginRemoteDataSourceSharedMethod(user: user);
      throw RefreshTokenExpireException();
    }
  } catch (e) {
    log(e.toString());
  }
}
