import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_bar_index_changer_state.dart';

class NavigationBarIndexChangerCubit
    extends Cubit<NavigationBarIndexChangerState> {
  NavigationBarIndexChangerCubit()
      : super(const NavigationBarIndexChangerState());

  void changeIndex(int index) {
    
    emit(NavigationBarIndexChangerState(currentIndex: index));
  }
}
