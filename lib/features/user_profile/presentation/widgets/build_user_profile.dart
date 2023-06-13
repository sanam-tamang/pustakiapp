import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/api.dart';
import '../../../../common/widgets/build_document_with_sliver_list.dart';
import '../../../../common/widgets/custom_error_dialog.dart';
import '../../../../common/widgets/person_avatar.dart';
import '../../../../common/widgets/pustaki_loading.dart';
import '../../../../core/data/model/user_model.dart';
import '../blocs/get_document_with_user_bloc/get_document_with_user_bloc.dart';

class BuildUserProfile extends StatefulWidget {
  const BuildUserProfile({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;

  @override
  State<BuildUserProfile> createState() => _BuildUserProfileState();
}

class _BuildUserProfileState extends State<BuildUserProfile>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context
        .read<GetDocumentWithUserBloc>()
        .add(GetDocumentWithUserIdEvent(userId: widget.user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context
              .read<GetDocumentWithUserBloc>()
              .add(GetDocumentWithUserIdEvent(userId: widget.user.id));
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(clipBehavior: Clip.none, children: [
                Container(
                  height: height * 0.25,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          offset: Offset(0, 1),
                          blurRadius: 1,
                        )
                      ],
                      color: Colors.grey.shade300,
                      image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          image: AssetImage('assets/icons/person.png'))),
                ),
                Positioned(
                  top: height * 0.06,
                  left: 5,
                  child: PersonAvatar(
                    radius: 90,
                    imageUrl: "$baseUrl${widget.user.image}",
                  ),
                ),
              ]),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height * 0.09,
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "${widget.user.firstName} ${widget.user.lastName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Joined ${widget.user.createdAt}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    )),
              ],
            )),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ).copyWith(top: 20, bottom: 8),
                child: Text(
                  "Your books",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(),
                ),
              ),
            ),
            BlocConsumer<GetDocumentWithUserBloc, GetDocumentWithUserState>(
                listener: (context, state) {
              if (state is GetDocumentWithUserFailureState) {
                customErrorDialog(context, errorMessage: state.errorMessage);
                return;
              }
            }, builder: (context, state) {
              if (state is GetDocumentWithUserLoadedState) {
                return BuildDocumentSliverList(
                  navigatedFrom: 'userprofilepage',
                  fetchWithUrl: state.fetchWithUrl,
                  paginationUrlCaller: () {
                    context.read<GetDocumentWithUserBloc>().add(
                        GetDocumentWithUserIdWithPaginationUrlEvent(
                            url: state.fetchWithUrl.nextUrl));
                  },
                );
              } else if (state is GetDocumentWithUserLoadingState) {
                return const SliverToBoxAdapter(
                    child: Center(child: PustakiLoading()));
              } else {
                return const SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
