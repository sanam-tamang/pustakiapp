import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pustakiapp/core/data/datasources/local_datasource/token_detail_local_datasource.dart';
import 'package:pustakiapp/core/data/model/user_login_model.dart';
import 'package:pustakiapp/common/widgets/custom_error_dialog.dart';
import 'package:pustakiapp/common/widgets/custom_snackbar.dart';
import 'package:pustakiapp/features/navigationbar/presentation/pages/navigationbar_page.dart';
import 'package:pustakiapp/features/user_auth/presentation/blocs/user_login_bloc/user_login_bloc.dart';
import 'package:pustakiapp/features/user_auth/presentation/pages/registration_page.dart';
import '../../../../common/widgets/custom_circular_progress_indicatior.dart';
import '../../../../common/widgets/custom_text_field.dart';

import '../../../../common/widgets/const_gap_between_text_fields.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});
  static const String id = 'user_login_page';

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    TokenDetailLocalDataSource.getAccessToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserLoginBloc, UserLoginState>(
        listener: (context, state) {
          if (state is UserLoginLoadedState) {
            customSnackbar(context, content: state.message);
            //when user login
            Navigator.of(context).pushReplacementNamed(CustomNavigationBar.id);
          } else if (state is UserLoginFailureState) {
            customErrorDialog(context, errorMessage: state.errorMessage);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.98,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const ConstantGapBetweenTextField(),
                const ConstantGapBetweenTextField(),
                CustomTextField(controller: emailController, hintText: 'Email'),
                const ConstantGapBetweenTextField(),
                CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obsecure: true),
                const ConstantGapBetweenTextField(),
                const ConstantGapBetweenTextField(),
                BlocBuilder<UserLoginBloc, UserLoginState>(
                  builder: (context, state) {
                    if (state is UserLoginLoadingState) {
                      return const ElevatedButton(
                          onPressed: null,
                          child: CustomCircularProgressIndicator(
                            prefixText: 'Login',
                          ));
                    } else {
                      return ElevatedButton(
                          onPressed: login, child: const Text("Login"));
                    }
                  },
                ),
                const ConstantGapBetweenTextField(),
                const ConstantGapBetweenTextField(),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const Text('Don\'t have an account yet?'),
                    Baseline(
                      baseline: 16,
                      baselineType: TextBaseline.alphabetic,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(UserRegistrationPage.id);
                          },
                          child: const Text("Create new")),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    final userLoginModel = UserLoginModel(
        email: emailController.text, password: passwordController.text);

    context
        .read<UserLoginBloc>()
        .add(UserLoginEvent(userLoginModel: userLoginModel));
  }
}
