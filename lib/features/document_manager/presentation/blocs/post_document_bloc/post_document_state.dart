// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_document_bloc.dart';

abstract class PostDocumentState extends Equatable {
  const PostDocumentState();

  @override
  List<Object> get props => [];
}

class PostDocumentInitial extends PostDocumentState {}

class PostDocumentLoadingState extends PostDocumentState {}

class PostDocumentLoadedState extends PostDocumentState {
  final String data;
 const  PostDocumentLoadedState({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class PostDocumentErrorState extends PostDocumentState {
  final String errorMessage;
  const PostDocumentErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
