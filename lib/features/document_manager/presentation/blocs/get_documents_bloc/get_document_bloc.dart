import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pustakiapp/common/utils/failure_message.dart';

import '../../../../../common/api.dart';
import '../../../../../core/data/datasources/local_datasource/token_detail_local_datasource.dart';
import '../../../data/models/document_model.dart';

import '../../../../../core/domain/usecase/get_document_usecase.dart';

part 'get_document_event.dart';
part 'get_document_state.dart';

class GetDocumentBloc extends Bloc<GetDocumentEvent, GetDocumentState> {
  final GetDocumentsUsecase _usecase;
  GetDocumentBloc({required GetDocumentsUsecase usecase})
      : _usecase = usecase,
        super(GetDocumentInitial()) {
    on<GetDocumentsEvent>(_onGetDocumentEvent);

    on<GetDocumentsWithPaginationUrlEvent>(_onGetDocumentsWithPaginationUrlEvent);
  }

  Future<void> _onGetDocumentsWithPaginationUrlEvent(
      GetDocumentsWithPaginationUrlEvent event,  Emitter<GetDocumentState> emit) async {
    final state = this.state;
    if (state is GetDocumentLoadedState) {
      final String? accessToken =
          await TokenDetailLocalDataSource.getAccessToken();
  
      final failureOrDocuments =
          await _usecase.call(accessToken: accessToken!, url: event.url!);
      failureOrDocuments?.fold((failure) {
        emit(GetDocumentFailureState(errorMessage: failureMessage(failure)));
      }, (document) {
        final List<FetchDocumentModel> currentList =
            List.from(state.fetchWithUrl.documents)
              ..addAll(document.documents);
  
        emit(GetDocumentLoadedState(
            fetchWithUrl: FetchDocumentModelWithPaginationUrl(
                count: document.count,
                previousUrl: document.previousUrl,
                nextUrl: document.nextUrl,
                documents: currentList)));
      });
    }
  }

  Future<void> _onGetDocumentEvent(GetDocumentsEvent event, Emitter<GetDocumentState> emit) async {
    emit(GetDocumentLoadingState());
    final String? accessToken =
        await TokenDetailLocalDataSource.getAccessToken();
  
    final failureOrDocuments =
        await _usecase.call(accessToken: accessToken!, url: bookListUrl);
    failureOrDocuments?.fold((failure) {
      emit(GetDocumentFailureState(errorMessage: failureMessage(failure)));
    }, (fetchWithUrl) {
      emit(GetDocumentLoadedState(fetchWithUrl: fetchWithUrl));
    });
  }
}
