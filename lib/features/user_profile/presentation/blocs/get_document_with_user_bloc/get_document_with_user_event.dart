// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_document_with_user_bloc.dart';

abstract class GetDocumentWithUserEvent extends Equatable {
  const GetDocumentWithUserEvent();

  @override
  List<Object> get props => [];
}

class GetDocumentWithUserIdEvent extends GetDocumentWithUserEvent {
  final String userId;
  const GetDocumentWithUserIdEvent({
    required this.userId,
  });


  @override
  List<Object> get props => [userId];
  
}

class GetDocumentWithUserIdWithPaginationUrlEvent
    extends GetDocumentWithUserEvent {
  final String? url;
  const GetDocumentWithUserIdWithPaginationUrlEvent({
    required this.url,
  });
 
}
