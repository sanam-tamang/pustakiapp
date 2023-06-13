import 'package:pustakiapp/features/user_profile/data/repositories/user_detail_repository_impl.dart';

import '../features/user_profile/data/datasources/user_detail_remote_datasource.dart';
import '../features/user_profile/domain/repositories/user_detail_repository.dart';
import '../features/user_profile/domain/usecases/user_detail_usecase.dart';
import '../features/user_profile/presentation/blocs/get_document_with_user_bloc/get_document_with_user_bloc.dart';
import '../features/user_profile/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'main_di.dart';

void userProfileDi() {
  sl.registerFactory(() => UserProfileBloc(usecase: sl()));
  sl.registerLazySingleton(() => UserDetailUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetDocumentWithUserBloc(usecase: sl()));
  sl.registerLazySingleton<UserDetailRepository>(
      () => UserDetailRepositoryImpl(remote: sl(), internet: sl()));

  sl.registerLazySingleton<UserDetailRemoteDataSource>(
      () => UserDetailRemoteDataSourceImpl(client: sl()));
}
