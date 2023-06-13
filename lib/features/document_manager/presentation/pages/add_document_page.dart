import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pustakiapp/common/app_colors.dart';

import 'package:pustakiapp/common/utils/file_picker_function.dart';
import 'package:pustakiapp/common/utils/image_picker_function.dart';
import 'package:pustakiapp/common/widgets/const_gap_between_text_fields.dart';
import 'package:pustakiapp/common/widgets/custom_circular_progress_indicatior.dart';
import 'package:pustakiapp/common/widgets/custom_error_dialog.dart';
import 'package:pustakiapp/common/widgets/custom_snackbar.dart';
import 'package:pustakiapp/common/widgets/custom_text_field.dart';
import 'package:pustakiapp/core/data/datasources/local_datasource/user_detail_local_datasource.dart';
import 'package:pustakiapp/core/data/model/user_model.dart';
import 'package:pustakiapp/features/document_manager/data/models/category_model.dart';
import 'package:pustakiapp/features/document_manager/data/models/send_document.dart';

import '../../../navigationbar/presentation/blocs/navigation_bar_index_changer_cubit/navigation_bar_index_changer_cubit.dart';
import '../blocs/post_document_bloc/post_document_bloc.dart';
import '../widgets/category_list_dropdown.dart';

class AddDocumentPage extends StatefulWidget {
  const AddDocumentPage({super.key});
  static const String id = "document_manager_page";

  @override
  State<AddDocumentPage> createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends State<AddDocumentPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  File? imageFile;
  File? documentFile;
  late final UserModel? user;
  String? selectedCategoryId;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    user = await UserDetailLocalDataSource.getUser();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create book post"),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ConstantGapBetweenTextField(),

            const _TextFieldValueTitleStyle(
              text: 'Title *',
            ),
            CustomTextField(
                controller: titleController, hintText: 'Add your title...'),
            const ConstantGapBetweenTextField(),
            const _TextFieldValueTitleStyle(
              text: 'Description *',
            ),

            CustomTextField(
              controller: descriptionController,
              hintText: 'Add your descrioption...',
              isDescriptionBox: true,
            ),
            const ConstantGapBetweenTextField(),
            const _TextFieldValueTitleStyle(
              text: 'Category *',
            ),

            CategoryListDropDownWidget(
              selecteId: (String? selectedId) {
                setState(() {
                  selectedCategoryId = selectedId;
                });
              },
            ),
            const ConstantGapBetweenTextField(),

            //category selector
            //will gohere

            imageFile != null
                ? Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(imageFile!)))),
                  )
                : Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 0),
                              blurRadius: 1)
                        ]),
                    child: const Icon(
                      Icons.image_outlined,
                      size: 50,
                    ),
                  ),
            const SizedBox(
              height: 5,
            ),

            TextButton.icon(
                onPressed: () async {
                  imageFile = await pickImageFromGallery();

                  setState(() {});
                },
                icon: const Icon(Icons.image_outlined),
                label: const Text("Choose Cover Image")),

            const ConstantGapBetweenTextField(),
            documentFile != null
                ? Text(documentFile!.path)
                : const SizedBox.shrink(),
            TextButton.icon(
                onPressed: () async {
                  documentFile = await customFilePicker();
                  setState(() {});
                },
                icon: const Icon(Icons.book_outlined),
                label: const Text("Choose Book")),

            const ConstantGapBetweenTextField(),

            BlocConsumer<PostDocumentBloc, PostDocumentState>(
              listener: (context, state) {
                if (state is PostDocumentLoadedState) {
                  titleController.clear();
                  descriptionController.clear();
                  imageFile = null;
                  documentFile = null;
                  selectedCategoryId = null;
                  setState(() {});
                }
              },
              builder: (context, state) {
                if (state is PostDocumentLoadingState) {
                  return const ElevatedButton(
                      onPressed: null,
                      child: CustomCircularProgressIndicator(
                        prefixText: 'Upload',
                      ));
                } else {
                  return ElevatedButton(
                      onPressed: _uploadBook, child: const Text("Upload"));
                }
              },
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  bool __validateFields() {
    if (titleController.text.isEmpty) {
      customErrorDialog(context, errorMessage: 'Title can\'t be empty');
      return false;
    }
    if (titleController.text.length > 100) {
      customErrorDialog(context, errorMessage: 'Title must be less than 100');
      return false;
    }
    if (descriptionController.text.isEmpty) {
      customErrorDialog(context, errorMessage: 'Description can\'t be empty');

      return false;
    }
    if (selectedCategoryId == null) {
      customErrorDialog(context, errorMessage: 'Category can\'t be empty');
      return false;
    }
    if (documentFile == null) {
      customErrorDialog(context, errorMessage: 'Document  can\'t be empty');
      return false;
    }
    if (imageFile == null) {
      customErrorDialog(context, errorMessage: 'Image can\'t be empty');
      return false;
    }
    return true;
  }

  void _uploadBook() {
    if (!__validateFields()) {
      return;
    }
    
    final CategoryModel category =
        CategoryModel(id: selectedCategoryId!, name: 'donotneedcategoryname');
    SendDocumentEntity sendDocumentEntity = SendDocumentEntity(
        title: titleController.text,
        description: descriptionController.text,
        image: imageFile!.path,
        document: documentFile!.path,
        categoryModel: category,
        user: user!);

    context
        .read<PostDocumentBloc>()
        .add(PostDocumentPostEvent(documentModel: sendDocumentEntity));
  }
}

class _TextFieldValueTitleStyle extends StatelessWidget {
  const _TextFieldValueTitleStyle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
