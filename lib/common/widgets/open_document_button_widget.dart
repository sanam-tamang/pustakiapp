// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:pustakiapp/features/document_manager/domain/entities/fetch_document.dart';

import '../pages/show_pdf_document_detail.dart';

class OpenDocumentButtonWidget extends StatelessWidget {
  const OpenDocumentButtonWidget(
      {Key? key, required this.document,required this.isOfflineView })
      : super(key: key);
  final FetchDocument document;
  final bool isOfflineView;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ShowPdfDocumentDetail.id, arguments: {
            'document': document,
            'isOfflineView': isOfflineView
          });
        },
        child: const Text('Open'));
  }
}
