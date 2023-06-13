import '../features/user_auth/presentation/blocs/user_login_bloc/user_login_bloc.dart';

import '../core/network/internet_connection_checker.dart';
import '../features/user_auth/data/repositories/user_repositories_impl.dart';
import '../features/user_auth/domain/usecases/user_login_usecase.dart';
import '../features/user_auth/presentation/blocs/user-registration_bloc/user_registration_bloc.dart';

import '../features/user_auth/data/datasources/user_auth_remote_datasource.dart';
import '../features/user_auth/domain/repositories/user_auth_repositories.dart';
import '../features/user_auth/domain/usecases/user_registration_usecase.dart';
import 'main_di.dart';

Future<void> userRegistrationAndLoginAuthDi() async {
  
  //user registration
  sl.registerFactory(() => UserRegistrationBloc(usecase: sl()));
  sl.registerLazySingleton(() => UserRegistrationUsecase(repositories: sl()));

//userlogin

sl.registerFactory(() => UserLoginBloc(usecase: sl()));
  sl.registerLazySingleton(() => UserLoginUsecase(repositories: sl()));

  //common login and registration and other usecases
  sl.registerLazySingleton<UserRepositories>(
      () => UserRepositoriesImpl(internetChecker: sl(), remote: sl()));
  sl.registerLazySingleton<UserAuthRemoteDataSource>(
      () => UserAuthRemoteDataSourceImpl());

  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionCheckerImpl(internet: sl()));
  
}


