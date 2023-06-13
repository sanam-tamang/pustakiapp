import 'dart:convert';

import 'package:pustakiapp/common/api.dart';
import 'package:pustakiapp/core/error/exception.dart';
import 'package:pustakiapp/features/document_manager/data/models/category_model.dart';
import 'package:pustakiapp/features/document_manager/data/models/send_document.dart';
import 'package:pustakiapp/features/document_manager/domain/entities/category.dart';

import '../models/document_model.dart';
import 'package:http/http.dart' as http;

abstract class DocumentManagerRemoteDataSource {
  Future<FetchDocumentModelWithPaginationUrl> getDocument(
      {required String accessToken, required String url});
  Future<List<Category>> getCategoryList(String accessToken);
  Future<String> postDocument(
      {required String accessToken, required SendDocumentEntity sendDocument});
}

class DocumentManagerRemoteDataSourceImpl
    implements DocumentManagerRemoteDataSource {
  @override
  Future<FetchDocumentModelWithPaginationUrl> getDocument(
      {required String accessToken, required String url}) async {
    final response = await http
        .get(Uri.parse(url), headers: {'authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);

      final FetchDocumentModelWithPaginationUrl documentModelWithPaginationUrl =
          FetchDocumentModelWithPaginationUrl.fromMap(decodedJson);
      return documentModelWithPaginationUrl;
    } else if (response.statusCode == 401) {
      throw RefreshTokenExpireException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> postDocument(
      {required String accessToken,
      required SendDocumentEntity sendDocument}) async {
    final Map<String, String> header = {
      'Content-Type': 'multipart/form-data',
      'authorization': 'Bearer $accessToken'
    };
    final http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(addBookUrl));
    request.headers.addAll(header);
    request.fields.addAll(sendDocument.toMap());
    request.files
        .add(await http.MultipartFile.fromPath('image', sendDocument.image));
    request.files.add(
        await http.MultipartFile.fromPath('document', sendDocument.document));

    final response = await request.send();
    if (response.statusCode == 201) {
      return "Successful";
    } else if (response.statusCode == 401) {
      throw RefreshTokenExpireException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Category>> getCategoryList(String accessToken) async {
    final response = await http.get(Uri.parse(categoryListUrl),
        headers: {'authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      final List<Category> categoryList =
          List.from(decodedJson).map((e) => CategoryModel.fromMap(e)).toList();
      return categoryList;
    } else if (response.statusCode == 401) {
      throw RefreshTokenExpireException();
    } else {
      throw ServerException();
    }
  }
}
