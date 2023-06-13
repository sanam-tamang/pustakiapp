import 'package:dartz/dartz.dart';
import 'package:pustakiapp/core/error/failure.dart';

import 'package:pustakiapp/features/document_manager/data/models/document_model.dart';
import 'package:pustakiapp/features/document_manager/domain/entities/category.dart';

import '../../data/models/send_document.dart';

abstract class DocumentRepository {
  ///the url is here the url which fetch data from api, we are performing like contineous scrolling for that we need to pass url also
  Future<Either<Failure, FetchDocumentModelWithPaginationUrl>> getDocument(
      {required String accessToken,required  String url});
  Future<Either<Failure, String>> postDocument(
      {required String accessToken, required SendDocumentEntity model});
  Future<Either<Failure, List<Category>>> getCategoryList(String accessToken);
}
