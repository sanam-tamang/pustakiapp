import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common/api.dart';
import '../../../../../common/utils/failure_message.dart';
import '../../../../../core/data/datasources/local_datasource/token_detail_local_datasource.dart';
import '../../../data/models/document_model.dart';
import '../../../domain/entities/category.dart';
import '../../../../../core/domain/usecase/get_document_usecase.dart';

part 'get_document_with_category_event.dart';
part 'get_document_with_category_state.dart';

class GetDocumentWithCategoryBloc
    extends Bloc<GetDocumentWithCategoryEvent, GetDocumentWithCategoryState> {
  final GetDocumentsUsecase _usecase;

  GetDocumentWithCategoryBloc({required GetDocumentsUsecase usecase}) : _usecase = usecase, super(GetDocumentWithCategoryInitial()) {
    on<GetDocumentWithCategoryIdEvent>(_onGetDocumentWithCategoryIdEvent);
    on<GetDocumentWithCategoryWithPaginationUrlEvent>(_onGetDocumentWithCategoryWithPaginationUrlEvent);
  }

  Future<void> _onGetDocumentWithCategoryWithPaginationUrlEvent(
      GetDocumentWithCategoryWithPaginationUrlEvent event,
      Emitter<GetDocumentWithCategoryState> emit) async {
    final state = this.state;
    if (state is GetDocumentWithCategoryLoadedState) {
      final String? accessToken =
          await TokenDetailLocalDataSource.getAccessToken();

      final failureOrDocuments =
          await _usecase.call(accessToken: accessToken!, url: event.url!);
      failureOrDocuments?.fold((failure) {
        emit(GetDocumentWithCategoryFailureState(errorMessage: failureMessage(failure)));
      }, (document) {
        final List<FetchDocumentModel> currentList =
            List.from(state.fetchWithUrl.documents)..addAll(document.documents);

        emit(GetDocumentWithCategoryLoadedState(
            fetchWithUrl: FetchDocumentModelWithPaginationUrl(
                count: document.count,
                previousUrl: document.previousUrl,
                nextUrl: document.nextUrl,
                documents: currentList)));
      });
    }
  }

  Future<void> _onGetDocumentWithCategoryIdEvent(
      GetDocumentWithCategoryIdEvent event, Emitter<GetDocumentWithCategoryState> emit) async {
    emit(GetDocumentWithCategoryLoadingState());
    final String? accessToken =
        await TokenDetailLocalDataSource.getAccessToken();

    final failureOrDocuments =
        await _usecase.call(accessToken: accessToken!, url: "$bookListWithCategoryUrl${event.category.id}");
    failureOrDocuments?.fold((failure) {
      emit(GetDocumentWithCategoryFailureState(errorMessage: failureMessage(failure)));
    }, (fetchWithUrl) {
      emit(GetDocumentWithCategoryLoadedState(fetchWithUrl: fetchWithUrl));
    });
  }
}
