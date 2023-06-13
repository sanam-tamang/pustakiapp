import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/api.dart';
import '../../../../../common/utils/failure_message.dart';
import '../../../../../core/data/datasources/local_datasource/token_detail_local_datasource.dart';
import '../../../../document_manager/data/models/document_model.dart';
import '../../../../../core/domain/usecase/get_document_usecase.dart';

part 'get_document_with_user_event.dart';
part 'get_document_with_user_state.dart';

class GetDocumentWithUserBloc
    extends Bloc<GetDocumentWithUserEvent, GetDocumentWithUserState> {
  final GetDocumentsUsecase _usecase;

  GetDocumentWithUserBloc({required GetDocumentsUsecase usecase})
      : _usecase = usecase,
        super(GetDocumentWithUserInitial()) {
    on<GetDocumentWithUserIdEvent>(_onGetDocumentWithUserEvent);
    on<GetDocumentWithUserIdWithPaginationUrlEvent>(
        _onGetDocumentWithUserWithPaginationUrlEvent);
  }

  Future<void> _onGetDocumentWithUserWithPaginationUrlEvent(
      GetDocumentWithUserIdWithPaginationUrlEvent event,
      Emitter<GetDocumentWithUserState> emit) async {
    final state = this.state;
    if (state is GetDocumentWithUserLoadedState) {
      final String? accessToken =
          await TokenDetailLocalDataSource.getAccessToken();

      final failureOrDocuments =
          await _usecase.call(accessToken: accessToken!, url: event.url!);
      failureOrDocuments?.fold((failure) {
        emit(GetDocumentWithUserFailureState(
            errorMessage: failureMessage(failure)));
      }, (document) {
        final List<FetchDocumentModel> currentList =
            List.from(state.fetchWithUrl.documents)..addAll(document.documents);

        emit(GetDocumentWithUserLoadedState(
            fetchWithUrl: FetchDocumentModelWithPaginationUrl(
                count: document.count,
                previousUrl: document.previousUrl,
                nextUrl: document.nextUrl,
                documents: currentList)));
      });
    }
  }

  Future<void> _onGetDocumentWithUserEvent(GetDocumentWithUserIdEvent event,
      Emitter<GetDocumentWithUserState> emit) async {
    emit(GetDocumentWithUserLoadingState());
    final String? accessToken =
        await TokenDetailLocalDataSource.getAccessToken();

    final failureOrDocuments = await _usecase.call(
        accessToken: accessToken!, url: "$bookListWithUserUrl${event.userId}");
    failureOrDocuments?.fold((failure) {
      emit(GetDocumentWithUserFailureState(
          errorMessage: failureMessage(failure)));
    }, (fetchWithUrl) {
      emit(GetDocumentWithUserLoadedState(fetchWithUrl: fetchWithUrl));
    });
  }
}
