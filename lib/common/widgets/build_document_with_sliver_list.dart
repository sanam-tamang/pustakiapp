// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:pustakiapp/common/utils/hero_tag.dart';
import 'package:pustakiapp/common/widgets/pustaki_cached_network_image.dart';

import '../../features/document_manager/data/models/document_model.dart';
import '../../features/document_manager/presentation/pages/document_detail_page.dart';
import '../../features/document_manager/presentation/widgets/custom_divider.dart';
import '../../features/document_manager/presentation/widgets/person_header_circle_avatar_image_name.dart';
import 'hero_widget.dart';
import 'open_document_button_widget.dart';
import 'pustaki_loading.dart';

///This need to called from customsliver parent widget
class BuildDocumentSliverList extends StatelessWidget {
  const BuildDocumentSliverList({
    Key? key,
    required this.navigatedFrom,
    required this.fetchWithUrl,
    required this.paginationUrlCaller,
  }) : super(key: key);

  final String navigatedFrom;

  final FetchDocumentModelWithPaginationUrl fetchWithUrl;
  final VoidCallback paginationUrlCaller;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final document = fetchWithUrl.documents[index];
        final publishedBy = document.publishedBy;

        return Column(
          children: [
            const CustomDivider(),

            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: BuildCircleAvatarWithUserName(
                  publishedBy: publishedBy, document: document),
            ),
            SizedBox(
              height: height * 0.005,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(DocumentDetailPage.id,
                    arguments: {'document': document,
                    
                    'navigatedFrom': navigatedFrom,
                    });
              },
              child: HeroWidget(
                tag: HeroTag.image(
                    navigatedFrom: navigatedFrom, image: document.image),
                child: AspectRatio(
                  aspectRatio: 6 / 8,
                  child: PustakiCachedNetworkImage(
                    image: document.image,
                  ),
                ),
              ),
            ),
            _FooterTitleCategoryWithOPenDocumentButon(
                document: document, navigatedFrom: navigatedFrom),

            ///This is call for next data to show in the list
            if (index == fetchWithUrl.documents.length - 1) ...{
              Builder(builder: (context) {
                ///if next url is not null then we are calling the function widget.paginationUrlCaller ()
                ///function
                fetchWithUrl.nextUrl != null ? paginationUrlCaller() : null;

                /// ### giving some space at the end of the books when there is not data left in server
                /// otherwise implementing circularprogress indicator
                return fetchWithUrl.nextUrl != null
                    ? const PustakiLoading()
                    : const SizedBox(
                        height: 20,
                      );
              })
            }
          ],
        );
      }, childCount: fetchWithUrl.documents.length),
    );
  }
}

class _FooterTitleCategoryWithOPenDocumentButon extends StatelessWidget {
  const _FooterTitleCategoryWithOPenDocumentButon({
    Key? key,
    required this.document,
    required this.navigatedFrom,
  }) : super(key: key);

  final FetchDocumentModel document;
  final String navigatedFrom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(document.categoryModel.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.black87)),
                Text(document.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.015,
          ),
          HeroWidget(
            tag: HeroTag.buttonTag(
                navigatedFrom: navigatedFrom, button: document.id),
            child: OpenDocumentButtonWidget(
              document: document,
              isOfflineView: false,
            ),
          ),
          const SizedBox(
            width: 25,
          ),
        ],
      ),
    );
  }
}
