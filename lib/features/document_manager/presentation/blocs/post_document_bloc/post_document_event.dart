// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_document_bloc.dart';

abstract class PostDocumentEvent extends Equatable {
  const PostDocumentEvent();

  @override
  List<Object> get props => [];
}

class PostDocumentPostEvent extends PostDocumentEvent {
  final SendDocumentEntity documentModel;
  const PostDocumentPostEvent({
    required this.documentModel,
  });

  @override
  List<Object> get props => [documentModel];
}
