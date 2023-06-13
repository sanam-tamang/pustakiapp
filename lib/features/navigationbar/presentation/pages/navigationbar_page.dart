// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/widgets/custom_error_dialog.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../document_manager/presentation/blocs/get_category_bloc/get_category_bloc.dart';
import '../../../document_manager/presentation/blocs/get_documents_bloc/get_document_bloc.dart';
import '../../../document_manager/presentation/blocs/post_document_bloc/post_document_bloc.dart';
import '../../../document_manager/presentation/pages/add_document_page.dart';
import '../../../document_manager/presentation/pages/home_page.dart';
import '../../../library/presentation/pages/library_page.dart';
import '../../../user_profile/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../user_profile/presentation/pages/user_profile_page.dart';
import '../blocs/navigation_bar_index_changer_cubit/navigation_bar_index_changer_cubit.dart';

PageStorageBucket bucket = PageStorageBucket();

class CustomNavigationBar extends StatefulWidget {
  static const String id = 'customnavigationbar';
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with AutomaticKeepAliveClientMixin {
  late List<Widget> destinationWidget;
  late PageController controller;

  @override
  void initState() {
    //accessing user information from the server to get the user id
    context.read<UserProfileBloc>().add(GetUserProfileUserDataEvent());
    context.read<GetCategoryBloc>().add(GetCategoryListEvent());
    context.read<GetDocumentBloc>().add(GetDocumentsEvent());
    log("*******Loadign data in navigationpage**************");

    destinationWidget = [
      BlocBuilder<GetCategoryBloc, GetCategoryState>(
        builder: (context, state) {
          if (state is GetCategoryLoadedState) {
            return HomePage(
              categories: state.categoryList,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      const AddDocumentPage(),
      const LibraryPage(),
      const UserProfilePage(),
    ];

    controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => NavigationBarIndexChangerCubit(),
      child: Builder(builder: (context) {
        return BlocBuilder<NavigationBarIndexChangerCubit,
            NavigationBarIndexChangerState>(
          builder: (context, state) {
            return Scaffold(
              body: BlocListener<PostDocumentBloc, PostDocumentState>(
                listener: (context, state) {
                  if (state is PostDocumentErrorState) {
                    customErrorDialog(context,
                        errorMessage: state.errorMessage);
                  } else if (state is PostDocumentLoadedState) {
                    customSnackbar(context, content: 'Your book is Uploaded');
                  } else if (state is PostDocumentLoadingState) {
                    customSnackbar(context, content: 'Uploading your book..');

                    ///this will back it to home page
                    /// if there is loading state in when uploading book

                    context
                        .read<NavigationBarIndexChangerCubit>()
                        .changeIndex(0);
                    controller.jumpToPage(0);

                    /////
                    ///
                  }
                },
                child: PageView.builder(
                    physics:const  NeverScrollableScrollPhysics(),
                    controller: controller,
                    itemCount: destinationWidget.length,
                    itemBuilder: (context, index) {
                      return destinationWidget[index];
                    }),
              ),
              bottomNavigationBar: BottomAppBar(
                child: NavigationBar(
                    shadowColor: AppColors.baseColor,
                    selectedIndex: state.currentIndex,
                    onDestinationSelected: (index) {
                      context
                          .read<NavigationBarIndexChangerCubit>()
                          .changeIndex(index);

                      controller.jumpToPage(index);
                    },
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysHide,
                    destinations: const [
                      NavigationDestination(
                          selectedIcon: _SelectedIcon(icon: Icons.home_filled),
                          icon: Icon(Icons.home_filled),
                          label: 'Home'),
                      NavigationDestination(
                          selectedIcon: _SelectedIcon(icon: Icons.add),
                          icon: Icon(Icons.add),
                          label: 'Add'),
                      NavigationDestination(
                          selectedIcon:
                              _SelectedIcon(icon: Icons.library_books),
                          icon: Icon(Icons.library_books),
                          label: 'Library'),
                      NavigationDestination(
                          selectedIcon: _SelectedIcon(icon: Icons.person),
                          icon: Icon(Icons.person),
                          label: 'Profile'),
                    ]),
              ),
            );
          },
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SelectedIcon extends StatelessWidget {
  const _SelectedIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(tileMode: TileMode.decal, colors: [
            Color.fromARGB(255, 18, 21, 234),
            Color.fromARGB(255, 59, 62, 244),
            Color.fromARGB(255, 54, 58, 249),
            Color.fromARGB(255, 137, 139, 250),
          ])),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
