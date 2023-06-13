// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:pustakiapp/core/error/exception.dart';

import 'package:pustakiapp/core/error/failure.dart';
import 'package:pustakiapp/features/library/domain/entities/after_file_downloaded_entity.dart';

import '../../../../core/network/internet_connection_checker.dart';
import '../../domain/repositories/library_repositories.dart';
import '../datasources/library_remote_datasource.dart';

class LibraryRepositoriesImpl implements LibraryRepositories {
  final InternetConnectionChecker internet;
  final LibraryRemoteDataSource remote;
  LibraryRepositoriesImpl({
    required this.internet,
    required this.remote,
  });
  @override
 Future<Either<Failure, AfterFileDownloadedEntity>> downloadFile({required String url, required void Function(int count, int total)? onReceiveProgress})async {
    if (await internet.isConnected) {
      try {
        final entity = await remote.downloadFile(url: url,onReceiveProgress: onReceiveProgress );
        return Right(entity);
      } on FileDownloadException {
        return Left(FileDownloadFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, String>> removeFile(String filePath) {
    // TODO: implement removeFile
    throw UnimplementedError();
  }
  
  
}
