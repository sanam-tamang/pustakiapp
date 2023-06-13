import 'package:flutter/material.dart';
import 'package:pustakiapp/common/widgets/custom_snackbar.dart';
import 'package:pustakiapp/features/user_auth/presentation/pages/login_page.dart';

import '../utils/failure_message.dart';

void customErrorDialog(BuildContext context, {required String errorMessage}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(errorMessage),
        );
      });

  ///if session is expired then it will push current page to the login page
  if (errorMessage == sessionExpire) {
    
    customSnackbar(context, content: errorMessage);
    Navigator.of(context).pushReplacementNamed(UserLoginPage.id);
    return;
  }
}
