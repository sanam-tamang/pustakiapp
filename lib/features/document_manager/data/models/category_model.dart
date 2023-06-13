import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({required super.id, required super.name});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
    );
  }
}
