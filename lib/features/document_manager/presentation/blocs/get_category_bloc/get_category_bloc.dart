import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pustakiapp/core/data/datasources/local_datasource/token_detail_local_datasource.dart';
import 'package:pustakiapp/features/document_manager/domain/entities/category.dart';

import '../../../../../common/utils/failure_message.dart';
import '../../../domain/usecases/get_document_category_list.dart';

part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategoryEvent, GetCategoryState> {
  final GetCategoryListUsecase _usecase;
  GetCategoryBloc({required GetCategoryListUsecase usecase})
      : _usecase = usecase,
        super(const GetCategoryLoadedState(categoryList: [])) {
    on<GetCategoryListEvent>((event, emit) async {
      emit(GetCategoryLoadingState());
      final String? accessToken =
          await TokenDetailLocalDataSource.getAccessToken();
      final failureOrCategoryList = await _usecase.call(accessToken!);
      failureOrCategoryList?.fold((failure) {
        emit(GetCategoryFailureState(errorMessage: failureMessage(failure)));
      }, (categoryList) {
        emit(GetCategoryLoadedState(categoryList: categoryList));
      });
    });
  }
}
