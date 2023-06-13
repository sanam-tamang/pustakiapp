part of 'get_document_with_user_bloc.dart';

abstract class GetDocumentWithUserState extends Equatable {
  const GetDocumentWithUserState();
  
  @override
  List<Object> get props => [];
}

class GetDocumentWithUserInitial extends GetDocumentWithUserState {}
class GetDocumentWithUserLoadingState extends GetDocumentWithUserState {}

class GetDocumentWithUserLoadedState extends GetDocumentWithUserState {
  final FetchDocumentModelWithPaginationUrl fetchWithUrl;
  const GetDocumentWithUserLoadedState({
    required this.fetchWithUrl,
  });
  @override
  List<Object> get props => [fetchWithUrl];
}

class GetDocumentWithUserFailureState extends GetDocumentWithUserState {
  final String errorMessage;
  const GetDocumentWithUserFailureState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
