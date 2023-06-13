import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pustakiapp/core/data/datasources/local_datasource/token_detail_local_datasource.dart';
import 'package:pustakiapp/core/data/datasources/local_datasource/user_detail_local_datasource.dart';

import 'package:pustakiapp/core/data/model/user_model.dart';

import '../../../../../common/utils/failure_message.dart';
import '../../../domain/usecases/user_detail_usecase.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserDetailUsecase _usecase;
  UserProfileBloc({required UserDetailUsecase usecase})
      : _usecase = usecase,
        super(UserProfileInitial()) {
    on<GetUserProfileUserDataEvent>((event, emit) async {
      emit(UserProfileLoadingState());
      final String? accessToken =
          await TokenDetailLocalDataSource.getAccessToken();
      final failureOrUserModel = await _usecase.call(accessToken!);
      await failureOrUserModel?.fold((failure) {
        emit(UserProfileErrorState(errorMessage: failureMessage(failure)));
      }, (userModel)async {
     
         await UserDetailLocalDataSource.saveUser(userModel);
        emit(UserProfileLoadedState(userModel: userModel));
      });
    });
  }
}
