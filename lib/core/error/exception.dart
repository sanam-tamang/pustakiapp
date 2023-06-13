

class PasswordException implements Exception {
  final String message;

  const PasswordException(this.message);
  @override
  String toString() {
    return message.toString();
  }
}

class EmailException implements Exception {
  final String message;

  const EmailException(this.message);
  @override
  String toString() {
    return message.toString();
  }
}


class LoginException implements Exception {
  final String message;

  const LoginException(this.message);
  @override
  String toString() {
    return message.toString();
  }
}

class ServerException implements Exception {}

///it is not refresh token but accesstoken expire exception but I had already named
///and used in everyplaces so I let it to be the same name as it does
class RefreshTokenExpireException implements Exception{}

class FileDownloadException implements Exception{
  
}