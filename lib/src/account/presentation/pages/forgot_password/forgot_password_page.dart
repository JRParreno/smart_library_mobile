import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:gap/gap.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/gen/assets.gen.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/data/datasources/forgot_password_repository_impl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  static const String routeName = '/account/forgot-password';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      appBar: buildAppBar(context: context, title: "Forgot Password"),
      body: CustomContainer(
        child: ProgressHUD(
          child: Builder(builder: (context) {
            final progressHUD = ProgressHUD.of(context);

            return Column(
              children: [
                Assets.lottie.loginAnimation.lottie(),
                const Gap(20),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextField(
                            textController: emailController,
                            labelText: "Email Address",
                            keyboardType: TextInputType.emailAddress,
                            padding: EdgeInsets.zero,
                            parametersValidate: 'required',
                            validators: (value) {
                              if (value != null &&
                                  EmailValidator.validate(value)) {
                                return null;
                              }
                              return "Please enter a valid email";
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomBtn(
                            label: "Submit",
                            onTap: () {
                              handleSubmitForgotPassword(progressHUD);
                            },
                            width: 275,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<void> handleSubmitForgotPassword(dynamic progressHUD) async {
    if (formKey.currentState!.validate()) {
      progressHUD?.show();

      try {
        final message = await ForgotPasswordRepositoryImpl()
            .forgotPassowrd(emailController.value.text);
        handleSuccessMessage('$message, kindly check your spam email thanks!');

        emailController.text = '';
      } catch (onError) {
        handleErrorMessage(onError.toString());
      }
      progressHUD?.dismiss();
    } else {
      handleErrorMessage('Invalid email address');
    }
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
}
