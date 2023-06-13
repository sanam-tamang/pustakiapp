import 'package:get_it/get_it.dart';
import 'package:pustakiapp/di/document_manager_di.dart';
import 'package:pustakiapp/di/external_dependencies.dart';
import 'package:pustakiapp/di/library_di.dart';
import 'package:pustakiapp/di/user_auth_di.dart';
import 'package:pustakiapp/di/user_profile_di.dart';

import 'core_di.dart';

GetIt sl = GetIt.instance;

Future<void> mainDi() async {
  userRegistrationAndLoginAuthDi();
  userProfileDi();
  documentManagerDi();
  coreDi();
  libraryDi();
  externalDi();
}
