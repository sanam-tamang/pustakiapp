// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/custom_circular_progress_indicatior.dart';
import '../blocs/get_category_bloc/get_category_bloc.dart';

class CategoryListDropDownWidget extends StatefulWidget {
  const CategoryListDropDownWidget({
    Key? key,
    required this.selecteId,
  }) : super(key: key);
  final void Function(String? selectedData) selecteId;

  @override
  State<CategoryListDropDownWidget> createState() =>
      _CategoryListDropDownWidgetState();
}

class _CategoryListDropDownWidgetState
    extends State<CategoryListDropDownWidget> {
  String? selectedId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoryBloc, GetCategoryState>(
      builder: (context, state) {
        if (state is GetCategoryLoadingState) {
          return const CustomCircularProgressIndicator();
        } else if (state is GetCategoryLoadedState) {
          return DropdownButton(
            value: selectedId,
            hint: const Text("Select Category"),
            items: state.categoryList
                .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
                .toList(),
            onChanged: (String? id) {
              setState(() {
                selectedId = id;
                widget.selecteId(id);
              });
            },
          );
        } else {
          return const Text("Failed to laod category");
        }
      },
    );
  }
}
