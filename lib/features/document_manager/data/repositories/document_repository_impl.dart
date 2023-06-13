// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:pustakiapp/core/error/exception.dart';

import 'package:pustakiapp/core/error/failure.dart';
import 'package:pustakiapp/core/network/internet_connection_checker.dart';
import 'package:pustakiapp/features/document_manager/data/models/document_model.dart';
import 'package:pustakiapp/features/document_manager/data/models/send_document.dart';
import 'package:pustakiapp/features/document_manager/domain/entities/category.dart';
import 'package:pustakiapp/features/document_manager/domain/repositories/document_repository.dart';

import '../datasources/document_manager_remote_data_source.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final InternetConnectionChecker internet;
  final DocumentManagerRemoteDataSource remote;
  DocumentRepositoryImpl({
    required this.internet,
    required this.remote,
  });
  @override
  Future<Either<Failure, FetchDocumentModelWithPaginationUrl>> getDocument(
      {required String accessToken, required String url}) async {
    if (await internet.isConnected) {
      try {
        final FetchDocumentModelWithPaginationUrl documents =
            await remote.getDocument(accessToken: accessToken, url: url);
        return Right(documents);
      } on ServerException {
        return Left(ServerFailure());
      } on RefreshTokenExpireException {
        return Left(RefreshTokenExpireFailure());
      }
    } else {
      return left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, String>> postDocument(
      {required String accessToken, required SendDocumentEntity model}) async {
    if (await internet.isConnected) {
      try {
        final String data = await remote.postDocument(
            accessToken: accessToken, sendDocument: model);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      } on RefreshTokenExpireException {
        return Left(RefreshTokenExpireFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategoryList(
      String accessToken) async {
    if (await internet.isConnected) {
      try {
        final categoryList = await remote.getCategoryList(accessToken);
        return Right(categoryList);
      } on ServerException {
        return Left(ServerFailure());
      } on RefreshTokenExpireException {
        return Left(RefreshTokenExpireFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
