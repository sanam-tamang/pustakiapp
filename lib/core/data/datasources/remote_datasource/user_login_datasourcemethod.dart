import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pustakiapp/core/data/model/user_login_model.dart';
import '../../../error/exception.dart';

import '../../../../common/api.dart';
import '../local_datasource/token_detail_local_datasource.dart';

Future<String> userLoginRemoteDataSourceSharedMethod(
    {required UserLoginModel user}) async {
  final http.Response response =
      await http.post(Uri.parse(loginUrl), body: user.toMap());
  if (response.statusCode == 200) {
    final Map<String, dynamic> decodedData = jsonDecode(response.body);

    TokenDetailLocalDataSource.saveAccessToken(decodedData['token']['access']);
    TokenDetailLocalDataSource.saveRefreshToken(
        decodedData['token']['refresh']);
    return 'Login successful';
  } else if (response.statusCode == 400) {
    final Map<String, dynamic> decodedData = jsonDecode(response.body);
    throw LoginException(decodedData['message']);
  } else {
    throw ServerException();
  }
}
