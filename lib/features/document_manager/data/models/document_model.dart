

import '../../../../core/data/model/user_model.dart';
import '../../domain/entities/fetch_document.dart';
import 'category_model.dart';

class FetchDocumentModel extends FetchDocument {
  const FetchDocumentModel(
      {required super.categoryModel,
      required super.publishedBy,
      required super.id,
      required super.title,
      required super.description,
      required super.image,
      required super.document,
      required super.publishedDate});

  factory FetchDocumentModel.fromMap(Map<String, dynamic> map) {
    return FetchDocumentModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      image: map['image'],
      document: map['document'],
      publishedDate: map['published_date'],
      categoryModel: CategoryModel.fromMap(map['category']),
      publishedBy: UserModel.fromMap(map['published_by']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'document': document,
      'published_date': publishedDate,
      'category': categoryModel.toMap(),
      'published_by': publishedBy.tomap()
    };
  }

  FetchDocumentModel copyWith({
    String? title,
    String? description,
    String? image,
    String? document,
    String? publishedDate,
    CategoryModel? categoryModel,
    UserModel? publishedBy,
  }) {
    return FetchDocumentModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      document: document ?? this.document,
      publishedDate: publishedDate ?? this.publishedDate,
      categoryModel: categoryModel ?? this.categoryModel,
      publishedBy: publishedBy ?? this.publishedBy,
    );
  }
}

class FetchDocumentModelWithPaginationUrl {
  final int? count;
  final String? previousUrl;
  final String? nextUrl;
  final List<FetchDocumentModel> documents;
  FetchDocumentModelWithPaginationUrl({
    this.count,
    this.previousUrl,
    this.nextUrl,
    required this.documents,
  });

  factory FetchDocumentModelWithPaginationUrl.fromMap(
      Map<String, dynamic> map) {
    return FetchDocumentModelWithPaginationUrl(
      count: map['count'] ,
      previousUrl: map['previous'],
      nextUrl: map['next'],
      documents: List.from(
        (map['results']).map(
          (x) => FetchDocumentModel.fromMap(x),
        ),
      ),
    );
  }
}
