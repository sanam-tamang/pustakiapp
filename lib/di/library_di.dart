import 'package:pustakiapp/features/library/data/repositories/library_repositories_impl.dart';
import 'package:pustakiapp/features/library/presentation/blocs/file_downloader_cubit/file_downloader_cubit.dart';

import 'package:pustakiapp/features/library/presentation/blocs/library_bloc/library_bloc.dart';

import '../features/library/data/datasources/library_remote_datasource.dart';
import '../features/library/domain/repositories/library_repositories.dart';
import '../features/library/domain/usecases/file_downloader_usecase.dart';
import '../features/library/domain/usecases/file_removal_usecase.dart';
import 'main_di.dart';

void libraryDi() {
  sl.registerLazySingleton(() => LibraryBloc(bloc: sl()));

  sl.registerLazySingleton(
      () => FileDownloaderCubit(fileDownloader: sl(), fileRemoval: sl()));

  sl.registerLazySingleton(() => FileDownloaderUsecase(repositories: sl()));
  sl.registerLazySingleton(() => FileRemovalUsecase(repositories: sl()));

  sl.registerLazySingleton<LibraryRepositories>(
      () => LibraryRepositoriesImpl(internet: sl(), remote: sl()));
  sl.registerLazySingleton<LibraryRemoteDataSource>(
      () => LibraryRemoteDataSourceImpl(dio: sl()));

}
