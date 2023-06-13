import 'package:equatable/equatable.dart';

class FileDownloadedPathEntity extends Equatable {
  final String imagePath;
  final String filePath;
  const FileDownloadedPathEntity({
    required this.imagePath,
    required this.filePath,
  });

  @override
  List<Object> get props => [imagePath, filePath];
}
