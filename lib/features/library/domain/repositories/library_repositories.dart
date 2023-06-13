// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/after_file_downloaded_entity.dart';

abstract class LibraryRepositories {
  Future<Either<Failure, AfterFileDownloadedEntity>> downloadFile({required String url,required  void Function(int, int)? onReceiveProgress} );
  Future<Either<Failure, String>> removeFile(String filePath);
}
