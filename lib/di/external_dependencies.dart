import 'package:dio/dio.dart';

import 'main_di.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> externalDi() async {
  ///External dependency
  sl.registerLazySingleton(() => InternetConnectionCheckerPlus());
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => Dio());
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
