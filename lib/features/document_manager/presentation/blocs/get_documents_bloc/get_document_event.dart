// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_document_bloc.dart';

abstract class GetDocumentEvent extends Equatable {
  const GetDocumentEvent();

  @override
  List<Object> get props => [];
}

class GetDocumentsEvent extends GetDocumentEvent {

}

class GetDocumentsWithPaginationUrlEvent extends GetDocumentEvent {
  final String? url;
  const GetDocumentsWithPaginationUrlEvent({
    required this.url,
  });
}
