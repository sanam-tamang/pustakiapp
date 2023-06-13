// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_document_with_category_bloc.dart';

abstract class GetDocumentWithCategoryEvent extends Equatable {
  const GetDocumentWithCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetDocumentWithCategoryIdEvent extends GetDocumentWithCategoryEvent {
  final Category category;
  const GetDocumentWithCategoryIdEvent({
    required this.category,
  });


  @override
  List<Object> get props => [category];
  
}

class GetDocumentWithCategoryWithPaginationUrlEvent
    extends GetDocumentWithCategoryEvent {
  final String? url;
  const GetDocumentWithCategoryWithPaginationUrlEvent({
    required this.url,
  });
}
