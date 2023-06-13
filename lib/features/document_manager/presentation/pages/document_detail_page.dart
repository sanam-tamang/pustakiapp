// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pustakiapp/common/widgets/pustaki_cached_network_image.dart';
import 'package:pustakiapp/features/document_manager/data/models/document_model.dart';

import '../../../../common/constant.dart';
import '../../../../common/utils/hero_tag.dart';
import '../../../../common/utils/stringtonumconverter.dart';
import '../../../../common/widgets/hero_widget.dart';
import '../../../library/presentation/blocs/file_downloader_cubit/file_downloader_cubit.dart';
import '../../../../common/widgets/open_document_button_widget.dart';

class DocumentDetailPage extends StatefulWidget {
  const DocumentDetailPage({
    Key? key,
    required this.document,
    required this.navigatedFrom,
  }) : super(key: key);
  final FetchDocumentModel document;
  static const String id = 'document_detail_page';

  ///navigated from basically tell us about fromwhere this detail page is
  ///navigated to get the data main reason of this varialbe is to provide hero
  ///animation
  final String navigatedFrom;
  @override
  State<DocumentDetailPage> createState() => _DocumentDetailPageState();
}

class _DocumentDetailPageState extends State<DocumentDetailPage> {
  late final FetchDocumentModel document;
  @override
  void initState() {
    document = widget.document;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _ImageStackWidget(
            document: document,
            navigatedFrom: widget.navigatedFrom,
          ),
          Stack(
            children: [
              Padding(
                padding: apphorintaltalPad,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      document.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _categoryWithDate(context)),
                        FileDownloaderButton(
                          document: document,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      document.description,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.6,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _categoryWithDate(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            "${document.categoryModel.name}, ",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Flexible(
          child: Text(
            document.publishedDate,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class _ImageStackWidget extends StatelessWidget {
  const _ImageStackWidget({
    required this.document,
    required this.navigatedFrom,
  });

  final FetchDocumentModel document;
  final String navigatedFrom;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Stack(clipBehavior: Clip.hardEdge, children: [
      SizedBox(
        height: height * 0.36,
      ),
      Positioned.fill(
        child: HeroWidget(
            tag: HeroTag.image(
                navigatedFrom: navigatedFrom, image: document.image),
            child: Stack(children: [
              PustakiCachedNetworkImage(image: document.image),
              const Positioned(top: 5, left: 5, child: _BackButton()),
            ])),
      ),
      Positioned(
        top: height * 0.32,
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          height: height * 0.73,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
        ),
      ),
      Positioned(
          right: width * 0.05,
          bottom: height * 0.01,
          child: HeroWidget(
            tag: HeroTag.buttonTag(
                navigatedFrom: navigatedFrom, button: document.id),
            child: OpenDocumentButtonWidget(
              document: document,
              isOfflineView: false,
            ),
          ))
    ]);
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(tileMode: TileMode.decal, colors: [
            Color.fromARGB(255, 10, 14, 204),
            Color.fromARGB(255, 18, 22, 221),
            Color.fromARGB(255, 88, 91, 250),
          ]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FileDownloaderButton extends StatelessWidget {
  const FileDownloaderButton({
    Key? key,
    required this.document,
  }) : super(key: key);
  final FetchDocumentModel document;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileDownloaderCubit, FileDownloaderState>(
      builder: (context, state) {
        if (state is FileDownloaderDownloadingState) {
          if (state.selectedId == document.id) {
            return Stack(children: [
              Container(),
              CircularProgressIndicator(
                value:
                    PustakiConverter.stringToDoubleDivideBy100(state.progress),
                color: Theme.of(context).colorScheme.primary,
              ),
              const Positioned.fill(child: Icon(Icons.download))
            ]);
          } else {
            return const Icon(
              Icons.downloading_outlined,
              color: Colors.grey,
            );
          }
        } else {
          return IconButton(
              onPressed: () {
                context.read<FileDownloaderCubit>().downloadFile(document);
              },
              icon: const Icon(Icons.download));
        }
      },
    );
  }
}
