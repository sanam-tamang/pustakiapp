import 'package:dartz/dartz.dart';

import 'package:pustakiapp/core/error/failure.dart';

import '../entities/after_file_downloaded_entity.dart';
import '../repositories/library_repositories.dart';

class FileDownloaderUsecase
     {
  final LibraryRepositories _repositories;
  FileDownloaderUsecase({required LibraryRepositories repositories})
      : _repositories = repositories;

  Future<Either<Failure, AfterFileDownloadedEntity>>? call(
     {required  String url,required void Function(int, int)? onReceiveProgress  }) async {
    return await _repositories.downloadFile(url: url, onReceiveProgress: onReceiveProgress);
  }
}
