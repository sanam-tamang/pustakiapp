import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'index_statck_counter_state.dart';

class IndexStatckCounterCubit extends Cubit<IndexStackLoadedState> {
  IndexStatckCounterCubit() : super(const IndexStackLoadedState(index: 0));
  void incrementIndex() {
    final state = this.state;
    emit(IndexStackLoadedState(index: state.index+1));
  }
}
