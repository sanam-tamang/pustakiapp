import 'package:flutter/material.dart';
import 'package:pustakiapp/features/document_manager/data/models/document_model.dart';
import '../features/document_manager/presentation/pages/add_document_page.dart';
import '../features/document_manager/presentation/pages/document_detail_page.dart';
import 'pages/show_pdf_document_detail.dart';
import '../features/navigationbar/presentation/pages/navigationbar_page.dart';
import '../features/user_auth/presentation/pages/registration_page.dart';

import '../features/user_auth/presentation/pages/login_page.dart';
import '../features/user_profile/presentation/pages/user_profile_page.dart';

class AppRoutes {
  static String root = "/";
  static Route onGenerateRoute(RouteSettings route) {
    return MaterialPageRoute(builder: (BuildContext context) {
      switch (route.name) {
        case UserLoginPage.id:
          return const UserLoginPage();
        case UserRegistrationPage.id:
          return const UserRegistrationPage();
        case UserProfilePage.id:
          return const UserProfilePage();
       
        case CustomNavigationBar.id:
          return const CustomNavigationBar();
        case AddDocumentPage.id:
          return const AddDocumentPage();
        case DocumentDetailPage.id:
          Map<String, dynamic> documentMap =
              route.arguments as Map<String, dynamic>;
          return DocumentDetailPage(
              navigatedFrom: documentMap['navigatedFrom'] as String,
              document: documentMap['document'] as FetchDocumentModel);
        case ShowPdfDocumentDetail.id:
          Map<String, dynamic> documentMap =
              route.arguments as Map<String, dynamic>;
          return ShowPdfDocumentDetail(
            document: documentMap['document'] as FetchDocumentModel,
            isOfflineView: documentMap['isOfflineView'] as bool,
          );
        default:
          return const Scaffold(
            body: Text("RouteError:)"),
          );
      }
    });
  }
}
