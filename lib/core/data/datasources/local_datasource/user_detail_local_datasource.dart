// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pustakiapp/core/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailLocalDataSource {
 

  static Future<UserModel?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? jsonData =sharedPreferences.getString('user');
    UserModel user = UserModel.fromMap(jsonDecode(jsonData!));

    return user;
  } 



  static Future<void> saveUser(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(user.tomap()));
  }
}
