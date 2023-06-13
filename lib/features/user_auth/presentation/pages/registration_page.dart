// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pustakiapp/features/user_auth/data/models/user_registration_model.dart';

import 'package:pustakiapp/features/user_auth/presentation/blocs/user-registration_bloc/user_registration_bloc.dart';
import 'package:pustakiapp/features/user_auth/presentation/pages/login_page.dart';

import '../../../../common/utils/image_picker_function.dart';
import '../../../../common/widgets/const_gap_between_text_fields.dart';
import '../../../../common/widgets/custom_circular_progress_indicatior.dart';
import '../../../../common/widgets/custom_error_dialog.dart';
import '../../../navigationbar/presentation/pages/navigationbar_page.dart';
import '../blocs/registration_index_statck_counter_cubit/index_statck_counter_cubit.dart';
import '../../../../common/widgets/custom_text_field.dart';

class UserRegistrationPage extends StatefulWidget {
  static const String id = 'user_registration_page';
  const UserRegistrationPage({super.key});

  @override
  State<UserRegistrationPage> createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => IndexStatckCounterCubit(),
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(UserLoginPage.id);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: BlocBuilder<IndexStatckCounterCubit,
                      IndexStackLoadedState>(
                    builder: (context, state) {
                      return IndexedStack(
                        index: state.index,
                        children: [
                          _FirstPage(
                            firstNameController: firstNameController,
                            lastNameController: lastNameController,
                          ),
                          _SecondPage(
                            emailController: emailController,
                            passwordController: passwordController,
                            register: register,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )),
        );
      }),
    );
  }

  void register(File? imageFile) {
    final user = UserRegistrationModel(
        password: passwordController.text,
        email: emailController.text.trim().toLowerCase(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        image: imageFile?.path);
    context
        .read<UserRegistrationBloc>()
        .add(UserRegistrationRegisterEvent(user: user));
  }

  @override
  bool get wantKeepAlive => true;
}

///this page contains first name and last name field
class _FirstPage extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  const _FirstPage({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
  }) : super(key: key);

  @override
  State<_FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<_FirstPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.98,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const ConstantGapBetweenTextField(),
            const ConstantGapBetweenTextField(),
            CustomTextField(
                controller: widget.firstNameController, hintText: 'First name'),
            const ConstantGapBetweenTextField(),
            CustomTextField(
                controller: widget.lastNameController, hintText: 'Last name'),
            const ConstantGapBetweenTextField(),
            const ConstantGapBetweenTextField(),
            ElevatedButton(
                onPressed: () {
                  if (!__validateFields()) {
                    return;
                  }
                  context.read<IndexStatckCounterCubit>().incrementIndex();
                },
                child: const Text("Next")),
          ],
        ),
      ),
    );
  }

  bool __validateFields() {
    if (widget.firstNameController.text.isEmpty ||
        widget.firstNameController.text.length > 45) {
      customErrorDialog(context,
          errorMessage: 'First name can\'t be empty or greater than 45');
      return false;
    }

    if (widget.lastNameController.text.isEmpty ||
        widget.firstNameController.text.length > 45) {
      customErrorDialog(context,
          errorMessage: 'Last name can\'t be empty or greater than 45');
      return false;
    }
    return true;
  }
}

///this page constain username, email and password field
class _SecondPage extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function(File? imageFile) register;
  const _SecondPage({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.register,
  }) : super(key: key);

  @override
  State<_SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<_SecondPage> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserRegistrationBloc, UserRegistrationState>(
      listener: (context, state) {
        if (state is UserRegistrationLoadedState) {
          Navigator.of(context).pushReplacementNamed(CustomNavigationBar.id);
        } else if (state is UserRegistrationErrorState) {
          customErrorDialog(context, errorMessage: state.message);
        }
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.98,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  imageFile != null
                      ? _CircleAvatar(image: FileImage(imageFile!))
                      : const _CircleAvatar(
                          image: AssetImage('assets/icons/person.png')),
                  Positioned(
                      bottom: 8,
                      right: 15,
                      child: CircleAvatar(
                        child: IconButton(
                            onPressed: () async {
                              imageFile = await pickImageFromGallery();
                              setState(() {});
                            },
                            icon: const Icon(Icons.camera_alt)),
                      ))
                ],
              ),
              const ConstantGapBetweenTextField(),
              const ConstantGapBetweenTextField(),
              const ConstantGapBetweenTextField(),
              CustomTextField(
                  controller: widget.emailController, hintText: 'Email'),
              const ConstantGapBetweenTextField(),
              CustomTextField(
                controller: widget.passwordController,
                hintText: 'Password',
                obsecure: true,
              ),
              const ConstantGapBetweenTextField(),
              const ConstantGapBetweenTextField(),
              BlocBuilder<UserRegistrationBloc, UserRegistrationState>(
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: state is UserRegistrationLoadingState
                          ? null
                          : () {
                              if (!__validateFields()) {
                                return;
                              }

                              widget.register(imageFile);
                            },
                      child: state is UserRegistrationLoadingState
                          ? const CustomCircularProgressIndicator(
                              prefixText: 'Register',
                            )
                          : const Text('Register'));
                },
              ),
              const ConstantGapBetweenTextField(),
              const ConstantGapBetweenTextField(),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  Baseline(
                    baseline: 16,
                    baselineType: TextBaseline.alphabetic,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(UserLoginPage.id);
                        },
                        child: const Text("Login here")),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool __validateFields() {
    if (imageFile == null) {
      customErrorDialog(context, errorMessage: 'Image field can\'t be empty');
      return false;
    }
    if (widget.emailController.text.isEmpty) {
      customErrorDialog(context, errorMessage: 'Email field can\'t be empty');

      return false;
    }
    if (widget.passwordController.text.isEmpty ||
        widget.passwordController.text.length > 15) {
      customErrorDialog(context,
          errorMessage: 'Password field can\'t be empty or greater than 15');

      return false;
    }
    return true;
  }
}

class _CircleAvatar extends StatelessWidget {
  const _CircleAvatar({required this.image});
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 100,
      backgroundColor: Colors.grey,
      child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                image: image),
          )),
    );
  }
}
