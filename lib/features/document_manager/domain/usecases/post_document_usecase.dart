// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:pustakiapp/features/document_manager/domain/repositories/document_repository.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/send_document.dart';

class PostDocumentUsecase {
  final DocumentRepository repository;
  const PostDocumentUsecase({
    required this.repository,
  });
  Future<Either<Failure, String>>? call(
      {required String accessToken, required SendDocumentEntity model}) async {
    return await repository.postDocument(
        accessToken: accessToken, model: model);
  }
}
