import 'package:pustakiapp/core/error/failure.dart';

const String sessionExpire = 'Session expired';
const String noInternetConnection = 'No internet connection';
const String serverException  = 'Server exception';
String failureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Server failure';
    case InternetFailure:
      return noInternetConnection;
    case EmailFailure:
      return failure.toString();
    case PasswordFailure:
      return failure.toString();
    case LoginFailure:
      return failure.toString();
    case RefreshTokenExpireFailure:
      return sessionExpire;
    case FileDownloadFailure:
      return 'Error downloading file';
    default:
      return 'Error! ';
  }
}
