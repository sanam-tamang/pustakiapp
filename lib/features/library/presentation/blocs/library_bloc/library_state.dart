// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

class LibraryInitial extends LibraryState {}

class LibrarySavingState extends LibraryState {
  final String progress;
  const LibrarySavingState({
    required this.progress,
  });

  @override
  List<Object> get props => [progress];
}

class LibrarySavedState extends LibraryState {
  final List<FetchDocumentModel> documents;
 const  LibrarySavedState({
    required this.documents,
  });
    @override
  List<Object> get props => [documents];
}

class LibraryFailureState extends LibraryState {
  final String message;
  const LibraryFailureState({
    required this.message,
  });
   @override
  List<Object> get props => [message];
}
