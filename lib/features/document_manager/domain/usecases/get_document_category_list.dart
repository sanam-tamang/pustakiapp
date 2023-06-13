import 'package:dartz/dartz.dart';
import 'package:pustakiapp/features/document_manager/domain/entities/category.dart';

import '../../../../core/error/failure.dart';
import '../repositories/document_repository.dart';

class GetCategoryListUsecase {
  final DocumentRepository repository;

  GetCategoryListUsecase({required this.repository});

  Future<Either<Failure, List<Category>>>? call(String accessToken) async {
    return await repository.getCategoryList(accessToken);
  }
}
