// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../common/api.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/after_file_downloaded_entity.dart';

abstract class LibraryRemoteDataSource {
  Future<AfterFileDownloadedEntity> downloadFile({required String url, required, required void Function(int p1, int p2)? onReceiveProgress});
}

class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final Dio dio;
  LibraryRemoteDataSourceImpl({
    required this.dio,
  });
  @override
  Future<AfterFileDownloadedEntity> downloadFile(
      {required String url,
      required,
      required void Function(int p1, int p2)? onReceiveProgress}) async {
    AfterFileDownloadedEntity afterFileDownloadedEntity =
        AfterFileDownloadedEntity();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${url.split('/').last}');
    final response =
        await dio.download(url, file.path, onReceiveProgress: (count, total) {
     
          onReceiveProgress!(count,total);
    });
    if (response.statusCode == 200) {
      afterFileDownloadedEntity.filePath = file.path;

      return afterFileDownloadedEntity;
    } else {
      throw FileDownloadException();
    }
  }
}
