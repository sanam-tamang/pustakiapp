import 'package:shared_preferences/shared_preferences.dart';



class TokenDetailLocalDataSource {
 
  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? access = sharedPreferences.getString('access');
    return access;
  }


  static Future<String?> getRefreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String? refresh = sharedPreferences.getString('refresh');
    return refresh;
  }


  static Future<void> saveAccessToken(String accessToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('access', accessToken);
  }


  static Future<void> saveRefreshToken(String refreshToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('refresh', refreshToken);
  }
}
