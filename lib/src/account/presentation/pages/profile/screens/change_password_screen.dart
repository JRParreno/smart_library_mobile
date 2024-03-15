import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:smart_libary_app/core/bloc/profile/profile_bloc.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/widgets/change_password/password_form.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = 'change-password';
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController passwordConfirmCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _passwordConfirmVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      appBar: buildAppBar(context: context, title: "Change Password"),
      body: CustomContainer(
        padding: const EdgeInsets.all(20),
        child: ProgressHUD(
          child: Builder(builder: (context) {
            final progressHUD = ProgressHUD.of(context);

            return BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoaded) {
                  if (state.isLoading) {
                    progressHUD?.show();
                    return;
                  }

                  progressHUD?.dismiss();
                  if (state.errorMessage == null) {
                    handleSuccessMessage('Successfully change your password!');
                    return;
                  }
                  handleErrorMessage(state.errorMessage ?? '');
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    PasswordForm(
                      formKey: formKey,
                      oldPasswordCtrl: oldPasswordCtrl,
                      passwordConfirmCtrl: passwordConfirmCtrl,
                      passwordCtrl: passwordCtrl,
                      onSubmit: handleSubmit,
                      confirmPasswordVisible: _passwordConfirmVisible,
                      confirmSuffixIcon: GestureDetector(
                        onTap: handleOnConfirmChangePassVisible,
                        child: Icon(!_passwordConfirmVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      passwordVisible: _passwordVisible,
                      suffixIcon: GestureDetector(
                        onTap: handleOnChangePassVisible,
                        child: Icon(!_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    )
                  ],
                );
              },
            );
          }),
        ),
      ),
    );
  }

  void handleErrorMessage(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: message,
      ),
    );
  }

  void handleSuccessMessage(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
      ),
    );
  }

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            OnChangePasswordProfileEvent(
              password: passwordCtrl.value.text,
              oldPassword: oldPasswordCtrl.value.text,
            ),
          );
    }
  }

  void handleOnConfirmChangePassVisible() {
    setState(() {
      _passwordConfirmVisible = !_passwordConfirmVisible;
    });
  }

  void handleOnChangePassVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
