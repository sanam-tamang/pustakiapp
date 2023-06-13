

import 'package:equatable/equatable.dart';

import '../../../../core/data/model/user_model.dart';
import '../../data/models/category_model.dart';

class FetchDocument extends Equatable {
  final String id;
  final String title;
  final String description;
  final String image;
  final String document;
  final String publishedDate;

  final CategoryModel categoryModel;
  final UserModel publishedBy;
  const FetchDocument({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.document,
    required this.publishedDate,
    required this.categoryModel,
    required this.publishedBy,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      image,
      document,
      publishedDate,
      categoryModel,
      publishedBy,
    ];
  }

}
