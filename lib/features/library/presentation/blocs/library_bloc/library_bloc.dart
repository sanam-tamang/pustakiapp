// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:pustakiapp/features/document_manager/data/models/document_model.dart';

import '../file_downloader_cubit/file_downloader_cubit.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends HydratedBloc<LibraryEvent, LibraryState> {
  final FileDownloaderCubit bloc;
  late StreamSubscription _streamController;
  LibraryBloc({required this.bloc})
      : super(const LibrarySavedState(documents: [])) {
    _streamController = bloc.stream.listen((state) {
      if (state is FileDownloaderDownloadedState) {
        add(SaveLibraryEvent(state.document));
        log("come on");
      } else if (state is FileDownloaderFailureState) {
        log("failed");
      }
    });
    on<UpdateLibraryEvent>(_onUpdateLibraryEvent);
    on<SaveLibraryEvent>(_onSaveLibraryEvent);
    on<DeleteLibraryEvent>(_onDeleteLibraryEvent);
    on<ProgressLibraryEvent>(_onProgressLibraryEvent);
  }

  FutureOr<void> _onSaveLibraryEvent(
      SaveLibraryEvent event, Emitter<LibraryState> emit) async {
    final state = this.state;

    if (state is LibrarySavedState) {
      final List<FetchDocumentModel> documents = List.from(state.documents);

      for (final document in documents) {
        if (event.document.id == document.id) {
          return;
        }
      }

      emit(LibrarySavedState(documents: documents..insert(0, event.document)));
    }
  }

  FutureOr<void> _onUpdateLibraryEvent(
      UpdateLibraryEvent event, Emitter<LibraryState> emit) {
    final state = this.state;

    if (state is LibrarySavedState) {
      final List<FetchDocumentModel> documents = List.from(state.documents);
      List<FetchDocumentModel> newDocuments = documents.map((e) {
        if (e.id == event.document.id) {
          return event.document;
        } else {
          return e;
        }
      }).toList();

      emit(LibrarySavedState(documents: newDocuments));
    }
  }

  FutureOr<void> _onDeleteLibraryEvent(
      DeleteLibraryEvent event, Emitter<LibraryState> emit) {
    final state = this.state;

    if (state is LibrarySavedState) {
      final List<FetchDocumentModel> documents = List.from(state.documents);
      documents.removeWhere((document) => event.document.id == document.id);

      emit(LibrarySavedState(documents: documents));
    }
  }

  ///TODO::
  ///progress in not implemented in entire app til now
  void _onProgressLibraryEvent(
      ProgressLibraryEvent event, Emitter<LibraryState> emit) {
    emit(const LibrarySavingState(progress: '0'));
  }

  @override
  LibraryState? fromJson(Map<String, dynamic> json) {
    log(json.toString());
    final list = List.from(json['data'])
        .map((e) => FetchDocumentModel.fromMap(e))
        .toList();
    return LibrarySavedState(documents: list);
  }

  @override
  Map<String, dynamic>? toJson(LibraryState state) {
    if (state is LibrarySavedState) {
      final data = state.documents.map((e) => e.toMap()).toList();

      return {'data': data};
    } else {
      return null;
    }
  }

  @override
  Future<void> close() {
    _streamController.cancel();
    return super.close();
  }
}
