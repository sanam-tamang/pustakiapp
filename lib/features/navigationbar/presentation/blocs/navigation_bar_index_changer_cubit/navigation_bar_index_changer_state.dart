// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'navigation_bar_index_changer_cubit.dart';

class NavigationBarIndexChangerState extends Equatable {
  final int currentIndex;
  const NavigationBarIndexChangerState({
    this.currentIndex = 0,
  });

  @override
  List<Object> get props => [currentIndex];
}
