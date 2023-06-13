// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_category_bloc.dart';

abstract class GetCategoryState extends Equatable {
  const GetCategoryState();

  @override
  List<Object> get props => [];
}

class GetCategoryInitial extends GetCategoryState {}

class GetCategoryLoadingState extends GetCategoryState {}

class GetCategoryLoadedState extends GetCategoryState {
  final List<Category> categoryList;
  const GetCategoryLoadedState({
    required this.categoryList,
  });
  @override
  List<Object> get props => [categoryList];
}

class GetCategoryFailureState extends GetCategoryState {
  final String errorMessage;
  const GetCategoryFailureState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
