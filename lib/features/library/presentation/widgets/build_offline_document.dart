// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pustakiapp/common/app_colors.dart';

import 'package:pustakiapp/features/document_manager/data/models/document_model.dart';
import 'package:pustakiapp/features/document_manager/presentation/widgets/custom_divider.dart';

import '../../../../common/widgets/open_document_button_widget.dart';

class BuildOfflineLibraryDocument extends StatefulWidget {
  const BuildOfflineLibraryDocument({
    Key? key,
    required this.documents,
  }) : super(key: key);
  final List<FetchDocumentModel> documents;

  @override
  State<BuildOfflineLibraryDocument> createState() =>
      _BuildOfflineLibraryDocumentState();
}

class _BuildOfflineLibraryDocumentState
    extends State<BuildOfflineLibraryDocument> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12,
        );
      },
      itemCount: widget.documents.length,
      itemBuilder: (context, index) {
        final document = widget.documents[index];

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                height: height * 0.18,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          spreadRadius: -5,
                          color: Color.fromARGB(255, 9, 49, 224),
                          blurRadius: 10,
                          offset: Offset(5, 5)),
                    ]),
              ),
            ),
            moreIconWidget(),
            imageWidget(document, width),
            _TitleWithPersonName(width: width, document: document),
            _openDocumentWidget(width, document)
          ],
        );
      },
    );
  }

  Positioned _openDocumentWidget(double width, FetchDocumentModel document) {
    return Positioned(
      left: width * 0.5,
      right: 15,
      bottom: 5,
      child: OpenDocumentButtonWidget(
        document: document,
        isOfflineView: true,
      ),
    );
  }

  Positioned imageWidget(FetchDocumentModel document, double width) {
    return Positioned(
      top: 5,
      bottom: 5,
      left: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.file(
          File(
            document.image,
          ),
          width: width * 0.46,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Positioned moreIconWidget() {
    return Positioned(
        top: -4,
        right: -12,
        child: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  onTap: () {
                    log("hello");
                  },
                  child: const Text("Delete"))
            ];
          },
        ));
  }
}

class _TitleWithPersonName extends StatelessWidget {
  const _TitleWithPersonName({
    super.key,
    required this.width,
    required this.document,
  });

  final double width;
  final FetchDocumentModel document;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 8,
        left: width * 0.5,
        bottom: 0,
        right: 25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              document.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${document.publishedBy.firstName} ${document.publishedBy.lastName}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ));
  }
}
