// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'library_bloc.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object> get props => [];
}

class SaveLibraryEvent extends LibraryEvent {
  const SaveLibraryEvent(
    this.document,
  );
  final FetchDocumentModel document;

  @override
  List<Object> get props => [document];
}

class UpdateLibraryEvent extends LibraryEvent {
  const UpdateLibraryEvent(
    this.document,
  );
  final FetchDocumentModel document;

  @override
  List<Object> get props => [document];
}

class DeleteLibraryEvent extends LibraryEvent {
  const DeleteLibraryEvent(
    this.document,
  );
  final FetchDocumentModel document;

  @override
  List<Object> get props => [document];
}



class ProgressLibraryEvent extends LibraryEvent {
 

  @override
  List<Object> get props => [];
}
