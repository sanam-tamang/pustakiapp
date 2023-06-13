import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common/utils/failure_message.dart';
import '../../../../../core/domain/entities/user.dart';
import '../../../data/models/user_registration_model.dart';
import '../../../domain/usecases/user_registration_usecase.dart';

part 'user_registration_event.dart';
part 'user_registration_state.dart';

class UserRegistrationBloc
    extends Bloc<UserRegistrationEvent, UserRegistrationState> {
  final UserRegistrationUsecase _usecase;
  UserRegistrationBloc({required UserRegistrationUsecase usecase})
      : _usecase = usecase,
        super(UserRegistrationInitial()) {
    on<UserRegistrationRegisterEvent>((event, emit) async {
      emit(UserRegistrationLoadingState());
      final failureOrUser = await _usecase.call(event.user);
      failureOrUser?.fold((failure) {
        emit(UserRegistrationErrorState(message: failureMessage(failure)));
      }, (user) {
        emit(UserRegistrationLoadedState(user: user));
      });
    });
  }
}
