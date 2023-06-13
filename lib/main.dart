import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pustakiapp/common/app_themes.dart';
import 'package:pustakiapp/features/document_manager/presentation/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:pustakiapp/features/document_manager/presentation/blocs/get_document_with_category_bloc/get_document_with_category_bloc.dart';
import 'package:pustakiapp/features/document_manager/presentation/blocs/get_documents_bloc/get_document_bloc.dart';
import 'package:pustakiapp/features/document_manager/presentation/blocs/post_document_bloc/post_document_bloc.dart';
import 'package:pustakiapp/features/library/presentation/blocs/file_downloader_cubit/file_downloader_cubit.dart';
import 'package:pustakiapp/features/library/presentation/blocs/library_bloc/library_bloc.dart';
import 'package:pustakiapp/features/user_auth/presentation/blocs/user-registration_bloc/user_registration_bloc.dart';
import 'package:pustakiapp/features/user_auth/presentation/blocs/user_login_bloc/user_login_bloc.dart';
import 'package:pustakiapp/features/user_auth/presentation/pages/login_page.dart';
import 'package:pustakiapp/features/user_profile/presentation/blocs/get_document_with_user_bloc/get_document_with_user_bloc.dart';
import 'package:pustakiapp/features/user_profile/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';

import 'common/app_routes.dart';
import 'di/main_di.dart' as di;
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di.mainDi();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory:kIsWeb
        ? HydratedStorage.webStorageDirectory: await getApplicationDocumentsDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<UserRegistrationBloc>()),
          BlocProvider(create: (context) => di.sl<UserLoginBloc>()),
          BlocProvider(create: (context) => di.sl<UserProfileBloc>()),
          BlocProvider(create: (context) => di.sl<PostDocumentBloc>()),
          BlocProvider(create: (context) => di.sl<GetCategoryBloc>()),
          BlocProvider(create: (context) => di.sl<GetDocumentBloc>()),
          BlocProvider(
              create: (context) => di.sl<GetDocumentWithCategoryBloc>()),
          BlocProvider(create: (context) => di.sl<FileDownloaderCubit>()),
          BlocProvider(create: (context) => di.sl<LibraryBloc>()),
          BlocProvider(create: (context) => di.sl<GetDocumentWithUserBloc>()),
        ],
        child: MaterialApp(
            title: 'Pustaki',
            theme: AppThemes.lightTheme(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            home: const UserLoginPage()));
  }
}
