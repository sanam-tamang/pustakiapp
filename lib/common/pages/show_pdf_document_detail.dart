import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pustakiapp/features/document_manager/data/models/document_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class ShowPdfDocumentDetail extends StatelessWidget {
  static const String id = 'pdfshowerdetail';
  const ShowPdfDocumentDetail(
      {super.key, required this.document,required this.isOfflineView});
  final FetchDocumentModel document;
  final bool isOfflineView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(document.title),
      ),
      body:isOfflineView? SfPdfViewer.file(File(document.document)): SfPdfViewer.network(document.document),
    );
  }
}
