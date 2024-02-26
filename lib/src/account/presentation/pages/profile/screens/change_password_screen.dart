import 'package:flutter/material.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/widgets/change_password/password_form.dart';

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

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      // EasyLoading.show();
      // if (passwordConfirmCtrl.text == passwordCtrl.text) {
      //   ProfileRepositoryImpl()
      //       .changePassword(
      //           oldPassword: oldPasswordCtrl.text,
      //           newPassword: passwordCtrl.text)
      //       .then((value) {
      //     showDialogReport("Successfully change your password!");
      //     passwordConfirmCtrl.text = "";
      //     passwordCtrl.text = "";
      //     oldPasswordCtrl.text = "";
      //     formKey.currentState!.reset();
      //   }).catchError((onError) {
      //     EasyLoading.dismiss();
      //     final DioException error = onError as DioException;
      //     if (error.response != null) {
      //       final response = error.response!.data;
      //       showDialogReport(response['error_message']);
      //     }
      //   }).whenComplete(() {
      //     EasyLoading.dismiss();
      //   });
      // } else {
      //   EasyLoading.dismiss();
      //   showDialogReport("Password and Confirm password doesn't match");
      // }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      appBar: buildAppBar(context: context, title: "Change Password"),
      body: CustomContainer(
        padding: const EdgeInsets.all(20),
        child: Column(
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
        ),
      ),
    );
  }
}
