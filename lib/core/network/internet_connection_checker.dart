// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class InternetConnectionChecker {
  Future<bool> get isConnected;
}

class InternetConnectionCheckerImpl implements InternetConnectionChecker {
  final InternetConnectionCheckerPlus internet;
  InternetConnectionCheckerImpl({
    required this.internet,
  });
  @override
  Future<bool> get isConnected async => await internet.hasConnection;
}
