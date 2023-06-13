part of 'get_document_with_category_bloc.dart';

abstract class GetDocumentWithCategoryState extends Equatable {
  const GetDocumentWithCategoryState();
  
  @override
  List<Object> get props => [];
}

class GetDocumentWithCategoryInitial extends GetDocumentWithCategoryState {}
class GetDocumentWithCategoryLoadingState extends GetDocumentWithCategoryState {}

class GetDocumentWithCategoryLoadedState extends GetDocumentWithCategoryState {
  final FetchDocumentModelWithPaginationUrl fetchWithUrl;
  const GetDocumentWithCategoryLoadedState({
    required this.fetchWithUrl,
  });
  @override
  List<Object> get props => [fetchWithUrl];
}

class GetDocumentWithCategoryFailureState extends GetDocumentWithCategoryState {
  final String errorMessage;
  const GetDocumentWithCategoryFailureState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
