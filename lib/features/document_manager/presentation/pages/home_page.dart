// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pustakiapp/common/widgets/custom_error_dialog.dart';

import 'package:pustakiapp/features/document_manager/presentation/blocs/get_document_with_category_bloc/get_document_with_category_bloc.dart';

import '../../../../common/widgets/pustaki_loading.dart';
import '../../domain/entities/category.dart';
import '../blocs/get_documents_bloc/get_document_bloc.dart';
import '../widgets/build_document_widget_with_sliver_appbar.dart';
import '../widgets/no_book_found_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.categories,
  }) : super(key: key);
  static const String id = "home_page";
  final List<Category> categories;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HomePage> {
  late TabController controller;

  ///This initial category basically have the all the books from the database like any kinds of the categoyr

  late Category initialCategory;
  @override
  void initState() {
    initialCategory = const Category(id: 'initialCatID', name: 'All');
    controller =
        TabController(length: widget.categories.length + 1, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) {
          return [
            SliverAppBar(
              title: Text(
                'Pustaki',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              bottom: TabBar(
                isScrollable: true,
                controller: controller,
                onTap: (index) {
                  if (index == 0) {
                    return;
                  } else {
                    int newIndex = index - 1;
                    //we added +1 earlier for adding initial category and we need to revert this logic
                    //to get desire result of document data
                    context.read<GetDocumentWithCategoryBloc>().add(
                        GetDocumentWithCategoryIdEvent(
                            category: widget.categories[newIndex]));
                  }
                },
                tabs: List.generate(
                  widget.categories.length + 1,
                  (index) {
                    if (index == 0) {
                      return Tab(
                        child: Text(initialCategory.name),
                      );
                    } else {
                      int newIndex = index - 1;
                      final category = widget.categories[newIndex];
                      return Tab(
                        child: Text(category.name),
                      );
                    }
                  },
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            const BuildInitialCategoryTabBarView(),
            ...widget.categories
                .map((e) => BuildAllCategoryTabBarViewExceptInitial(
                      categoryId: e.id,
                    )),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BuildInitialCategoryTabBarView extends StatelessWidget {
  const BuildInitialCategoryTabBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetDocumentBloc, GetDocumentState>(
      listener: (context, state) {
        if (state is GetDocumentFailureState) {
          customErrorDialog(context, errorMessage: state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is GetDocumentLoadingState) {
          return const Center(
            child: PustakiLoading(),
          );
        } else if (state is GetDocumentLoadedState) {
          if (state.fetchWithUrl.documents.isEmpty) {
            return const FetChDocumentEmptyDataWidget();
          }
          return BuildDocumentWidgetWithCustomSliver(
            navigatedFrom: 'homepageinitialcategory',
            onRefresh: () async {
              context.read<GetDocumentBloc>().add(GetDocumentsEvent());
            },
            fetchWithUrl: state.fetchWithUrl,
            paginationUrlCaller: () {
              ///this calls paginated url
              context.read<GetDocumentBloc>().add(
                  GetDocumentsWithPaginationUrlEvent(
                      url: state.fetchWithUrl.nextUrl!));
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class BuildAllCategoryTabBarViewExceptInitial extends StatelessWidget {
  const BuildAllCategoryTabBarViewExceptInitial({
    Key? key,
    required this.categoryId,
  }) : super(key: key);
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetDocumentWithCategoryBloc,
        GetDocumentWithCategoryState>(
      listener: (context, state) {
        if (state is GetDocumentWithCategoryFailureState) {
          customErrorDialog(context, errorMessage: state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is GetDocumentWithCategoryLoadingState) {
          return const Center(child: PustakiLoading());
        } else if (state is GetDocumentWithCategoryLoadedState) {
          if (state.fetchWithUrl.documents.isEmpty) {
            return const FetChDocumentEmptyDataWidget();
          }
          return BuildDocumentWidgetWithCustomSliver(
            navigatedFrom: categoryId,
            onRefresh: () async {
              ///TODO:: I am not using refresh for category for now
            },
            fetchWithUrl: state.fetchWithUrl,
            paginationUrlCaller: () {
              ///this calls paginated url
              context.read<GetDocumentWithCategoryBloc>().add(
                  GetDocumentWithCategoryWithPaginationUrlEvent(
                      url: state.fetchWithUrl.nextUrl!));
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
