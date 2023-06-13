// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_document_bloc.dart';

abstract class GetDocumentState extends Equatable {
  const GetDocumentState();

  @override
  List<Object> get props => [];
}

class GetDocumentInitial extends GetDocumentState {}

class GetDocumentLoadingState extends GetDocumentState {}

class GetDocumentLoadedState extends GetDocumentState {
  final FetchDocumentModelWithPaginationUrl fetchWithUrl;
  const GetDocumentLoadedState({
    required this.fetchWithUrl,
  });
  @override
  List<Object> get props => [fetchWithUrl];
}

class GetDocumentFailureState extends GetDocumentState {
  final String errorMessage;
  const GetDocumentFailureState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
