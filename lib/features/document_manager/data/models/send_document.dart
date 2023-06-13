import 'package:equatable/equatable.dart';

import 'package:pustakiapp/core/data/model/user_model.dart';

import 'category_model.dart';

class SendDocumentEntity extends Equatable {
  final String title;
  final String description;
  final String image;
  final String document;
  final CategoryModel categoryModel;
  final UserModel user;
  const SendDocumentEntity({
    required this.title,
    required this.description,
    required this.image,
    required this.document,
    required this.categoryModel,
    required this.user,
  });

  @override
  List<Object> get props {
    return [
      title,
      description,
      image,
      document,
      categoryModel,
      user,
    ];
  }

  Map<String, String> toMap() {
    return <String, String>{
      'title': title,
      'description': description,
      'category': categoryModel.id,
      'published_by': user.id,
    };
  }
}
