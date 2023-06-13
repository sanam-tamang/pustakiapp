import 'package:dartz/dartz.dart';
import 'package:pustakiapp/core/domain/usecase/usecase.dart';
import 'package:pustakiapp/core/error/failure.dart';

import '../repositories/library_repositories.dart';

class FileRemovalUsecase implements Usecase<String, String> {
  final LibraryRepositories _repositories;
  FileRemovalUsecase({required LibraryRepositories repositories})
      : _repositories = repositories;
  @override
  Future<Either<Failure, String>>? call(String filePath) async {
    return await _repositories.removeFile(filePath);
  }
}
