// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pustakiapp/common/widgets/custom_error_dialog.dart';

import 'package:pustakiapp/features/user_profile/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';

import '../blocs/get_document_with_user_bloc/get_document_with_user_bloc.dart';
import '../widgets/build_user_profile.dart';

class UserProfilePage extends StatefulWidget {
  static const String id = 'user_profile_page';
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
      
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileErrorState) {
            customErrorDialog(context, errorMessage: state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is UserProfileLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is UserProfileLoadedState) {
            return BuildUserProfile(user: state.userModel);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
