import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/library_bloc/library_bloc.dart';
import '../widgets/build_offline_document.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});
  static const String libraryPage = 'librayr_page';

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Downloads",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        body: BlocBuilder<LibraryBloc, LibraryState>(
          builder: (context, state) {
            if (state is LibrarySavedState) {
              return BuildOfflineLibraryDocument(
                documents: state.documents,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
