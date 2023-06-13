import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data/model/user_login_model.dart';
import '../../../domain/usecases/user_login_usecase.dart';
import '../../../../../common/utils/failure_message.dart';

part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final UserLoginUsecase _usecase;
  UserLoginBloc({required UserLoginUsecase usecase})
      : _usecase = usecase,
        super(UserLoginInitial()) {
    on<UserLoginEvent>((event, emit) async {
      emit(UserLoginLoadingState());
      final failureOrLogin = await _usecase.call(event.userLoginModel);
      failureOrLogin?.fold((failure) {
        
        emit(UserLoginFailureState(errorMessage: failureMessage(failure)));
      }, (message) {
        emit(UserLoginLoadedState(message: message));
      });
    });
  }
}
