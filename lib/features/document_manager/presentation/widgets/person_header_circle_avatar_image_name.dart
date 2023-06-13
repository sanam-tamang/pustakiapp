import 'package:flutter/material.dart';

import '../../../../common/widgets/person_avatar.dart';
import '../../../../core/data/model/user_model.dart';
import '../../data/models/document_model.dart';

class BuildCircleAvatarWithUserName extends StatelessWidget {
  const BuildCircleAvatarWithUserName({
    super.key,
    required this.publishedBy,
    required this.document,
  });

  final UserModel publishedBy;
  final FetchDocumentModel document;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PersonAvatar(
          imageUrl: publishedBy.image,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${publishedBy.firstName} ${publishedBy.lastName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(document.publishedDate)
          ],
        ),
      ],
    );
  }
}
