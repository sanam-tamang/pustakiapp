// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AfterFileDownloadedEntity {
  String? _filePath;

  

  set filePath(String path) {
    _filePath = path;
  }

  String get filePath => _filePath!;
}

