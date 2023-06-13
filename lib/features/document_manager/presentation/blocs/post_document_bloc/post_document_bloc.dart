import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pustakiapp/core/data/datasources/local_datasource/token_detail_local_datasource.dart';

import 'package:pustakiapp/features/document_manager/domain/usecases/post_document_usecase.dart';

import '../../../../../common/utils/failure_message.dart';
import '../../../data/models/send_document.dart';

part 'post_document_event.dart';
part 'post_document_state.dart';

class PostDocumentBloc extends Bloc<PostDocumentEvent, PostDocumentState> {
  final PostDocumentUsecase _usecase;
  PostDocumentBloc({required PostDocumentUsecase usecase})
      : _usecase = usecase,
        super(PostDocumentInitial()) {
    on<PostDocumentPostEvent>((event, emit) async {
      emit(PostDocumentLoadingState());
      final String? accessToken =
          await TokenDetailLocalDataSource.getAccessToken();
      final failureOrDocument = await _usecase.call(
          accessToken: accessToken!, model: event.documentModel);
      failureOrDocument?.fold((failure) {
        emit(PostDocumentErrorState(errorMessage: failureMessage(failure)));
      }, (data) {
        emit(PostDocumentLoadedState(data: data));
      });
    });
  }
}
