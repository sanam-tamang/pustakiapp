import 'package:pustakiapp/features/document_manager/domain/usecases/get_document_category_list.dart';
import 'package:pustakiapp/core/domain/usecase/get_document_usecase.dart';
import 'package:pustakiapp/features/document_manager/presentation/blocs/get_documents_bloc/get_document_bloc.dart';

import '../features/document_manager/data/repositories/document_repository_impl.dart';
import '../features/document_manager/presentation/blocs/get_category_bloc/get_category_bloc.dart';
import '../features/document_manager/presentation/blocs/get_document_with_category_bloc/get_document_with_category_bloc.dart';
import '../features/document_manager/presentation/blocs/post_document_bloc/post_document_bloc.dart';

import '../features/document_manager/data/datasources/document_manager_remote_data_source.dart';
import '../features/document_manager/domain/repositories/document_repository.dart';
import '../features/document_manager/domain/usecases/post_document_usecase.dart';
import 'main_di.dart';

void documentManagerDi() {
  sl.registerFactory(() => PostDocumentBloc(usecase: sl()));
  sl.registerLazySingleton(() => GetCategoryBloc(usecase: sl()));
  sl.registerLazySingleton(() => GetDocumentWithCategoryBloc(usecase: sl()));
  sl.registerFactory(() => GetDocumentBloc(usecase: sl()));

  sl.registerLazySingleton(() => PostDocumentUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetCategoryListUsecase(repository: sl()));


  sl.registerLazySingleton<DocumentRepository>(
      () => DocumentRepositoryImpl(internet: sl(), remote: sl()));
  sl.registerLazySingleton<DocumentManagerRemoteDataSource>(
      () => DocumentManagerRemoteDataSourceImpl());
}
