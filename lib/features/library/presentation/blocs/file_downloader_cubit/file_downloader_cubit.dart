// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pustakiapp/features/document_manager/data/models/document_model.dart';
import 'package:pustakiapp/features/library/domain/usecases/file_downloader_usecase.dart';

import '../../../../../common/utils/failure_message.dart';
import '../../../domain/entities/after_file_downloaded_entity.dart';
import '../../../domain/usecases/file_removal_usecase.dart';

part 'file_downloader_state.dart';

class FileDownloaderCubit extends Cubit<FileDownloaderState> {
  final FileDownloaderUsecase fileDownloader;
  final FileRemovalUsecase fileRemoval;
  FileDownloaderCubit({required this.fileDownloader, required this.fileRemoval})
      : super(FileDownloaderInitial());

  void downloadFile(FetchDocumentModel document) async {
    double tempProgressPertance = 0;
    emit(FileDownloaderDownloadingState(
        progress: tempProgressPertance.toString(), selectedId: document.id));

    ///!!!## downloading image file first
    final failureOrImagePath = await fileDownloader.call(
        url: document.image,
        onReceiveProgress: (int count, int total) {
          ///letting image file only 10 pertange of total download file
          /// progressPertance =
          tempProgressPertance = ((count / total) * 10);
          emit(FileDownloaderDownloadingState(
              progress: tempProgressPertance.toString(),
              selectedId: document.id));
        });

    await failureOrImagePath?.fold((failure) {
      emit(FileDownloaderFailureState(message: failureMessage(failure)));
    }, (imageEntity) async {
      //# if successfull to download image

      __fileDownloader(
          document: document,
          tempProgressPertance: tempProgressPertance,
          imageEntity: imageEntity);
    });
  }

  Future<void> __fileDownloader({
    required FetchDocumentModel document,
    required double tempProgressPertance,
    required AfterFileDownloadedEntity imageEntity,
  }) async {
    double progressPertance = 0;
    ////!!!!!!! downloading document file
    final failureOrFilePath = await fileDownloader.call(
        url: document.document,
        onReceiveProgress: (int count, int total) {
          ///it is 90 % to multiply by 90
          progressPertance = ((count / total) * 10) * 90 + tempProgressPertance;
          emit(FileDownloaderDownloadingState(
              progress: progressPertance.toString(), selectedId: document.id));
        });

    failureOrFilePath?.fold((failure) {
      emit(FileDownloaderFailureState(message: failureMessage(failure)));
    }, (fileEntity) {
      /// # if successful to download file then we save whole data to our local storage

      final documet = document.copyWith(
          image: imageEntity.filePath, document: fileEntity.filePath);
      emit(FileDownloaderDownloadedState(document: documet));
    });
  }
}
