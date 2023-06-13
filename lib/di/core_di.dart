import '../core/domain/usecase/get_document_usecase.dart';
import 'main_di.dart';

void coreDi(){
    sl.registerLazySingleton(() => GetDocumentsUsecase(repository: sl()));
}