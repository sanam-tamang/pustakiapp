// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'file_downloader_cubit.dart';

abstract class FileDownloaderState extends Equatable {
  const FileDownloaderState();

  @override
  List<Object> get props => [];
}

class FileDownloaderInitial extends FileDownloaderState {}

class FileDownloaderDownloadingState extends FileDownloaderState {
  final String progress;
  final String selectedId;
  const FileDownloaderDownloadingState({
    required this.progress,
    required this.selectedId,
  });

  @override
  List<Object> get props => [progress, selectedId];
}

class FileDownloaderDownloadedState extends FileDownloaderState {
  final FetchDocumentModel document;
  const FileDownloaderDownloadedState({
    required this.document,
  });

  @override
  List<Object> get props => [document];
}

class FileDownloaderFailureState extends FileDownloaderState {
  final String message;
 const  FileDownloaderFailureState({
    required this.message,
  });

  @override
  List<Object> get props => [message];

}
