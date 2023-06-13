// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:pustakiapp/common/api.dart';
import 'package:pustakiapp/core/data/datasources/remote_datasource/user_login_datasourcemethod.dart';
import 'package:pustakiapp/core/error/exception.dart';
import 'package:pustakiapp/core/data/model/user_model.dart';

import '../../../../core/data/datasources/local_datasource/token_detail_local_datasource.dart';
import '../../../../core/data/model/user_login_model.dart';
import '../../../../core/domain/entities/user.dart';
import '../models/user_registration_model.dart';

abstract class UserAuthRemoteDataSource {
  Future<User> register(UserRegistrationModel user);
  Future<String> login(UserLoginModel user);
}

class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource {
  @override
  Future<String> login(UserLoginModel user) async {
    return userLoginRemoteDataSourceSharedMethod(user: user);
  }

  @override
  Future<User> register(UserRegistrationModel user) async {
    const String fieldRequired = "field is required.";

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(registrationUrl),
    );

    request.fields['first_name'] = user.firstName;
    request.fields['last_name'] = user.lastName;
    request.fields['email'] = user.email;
    request.fields['password'] = user.password;
    if (user.image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', user.image!));
    }

    final response = await request.send();
    if (response.statusCode == 201) {
      final Map<String, dynamic> decodedData =
          jsonDecode(await response.stream.bytesToString());
      TokenDetailLocalDataSource.saveAccessToken(
          decodedData['token']['access']);
      TokenDetailLocalDataSource.saveRefreshToken(
          decodedData['token']['refresh']);

      final User registeredUser = UserModel.fromMap(decodedData['user']);

      return registeredUser;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic>? data =
          jsonDecode(await response.stream.bytesToString());
      // log("${password['passowrd']}");

      bool? isEmail = data?.containsKey(['email'][0]);
      bool? isPassword = data?.containsKey(['password'][0]);
      if (isEmail == true) {
        String email = data?['email'][0];
        throw EmailException(
            __checkWithRequiredError(email) ? 'Email $fieldRequired' : email);
      } else if (isPassword == true) {
        String password = data?['password'][0];
        throw PasswordException(__checkWithRequiredError(password)
            ? 'Password $fieldRequired'
            : password);
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }

  bool __checkWithRequiredError(String error) {
    return error == "This field may not be blank." ||
        error == "This field is required.";
  }
}
