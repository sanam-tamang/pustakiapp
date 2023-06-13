import 'package:flutter/material.dart';

import '../../../../common/widgets/build_document_with_sliver_list.dart';
import '../../data/models/document_model.dart';

///This widget [BuildDocumentWidgetWithCustomSliver] will help to show the book or post of book
///
class BuildDocumentWidgetWithCustomSliver extends StatelessWidget {
  const BuildDocumentWidgetWithCustomSliver({
    Key? key,
    required this.fetchWithUrl,
    required this.paginationUrlCaller,
    required this.onRefresh,
    required this.navigatedFrom,
  }) : super(key: key);

  final FetchDocumentModelWithPaginationUrl fetchWithUrl;
  final VoidCallback paginationUrlCaller;
  final Future<void> Function() onRefresh;
  final String navigatedFrom;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      ///refreshing data
      onRefresh: onRefresh,
      child: CustomScrollView(
        key: PageStorageKey(navigatedFrom),
        physics: const BouncingScrollPhysics(),
        slivers: [ 
          BuildDocumentSliverList(
            fetchWithUrl: fetchWithUrl,
            paginationUrlCaller: paginationUrlCaller, navigatedFrom: '',
          ),
        ],
      ),
    );
  }
}
