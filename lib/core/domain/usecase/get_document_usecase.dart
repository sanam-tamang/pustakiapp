import 'package:dartz/dartz.dart';
import 'package:pustakiapp/features/document_manager/data/models/document_model.dart';

import '../../error/failure.dart';
import '../../../features/document_manager/domain/repositories/document_repository.dart';

class GetDocumentsUsecase {
  final DocumentRepository repository;

  GetDocumentsUsecase({required this.repository});

  Future<Either<Failure,FetchDocumentModelWithPaginationUrl>>? call(
      {required String accessToken,required  String url}) async {
    return await repository.getDocument(accessToken: accessToken, url:  url);
  }
}
