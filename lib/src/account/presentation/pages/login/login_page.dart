import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/gen/assets.gen.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:smart_libary_app/src/account/presentation/pages/signup/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/account/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: buildAppBar(
        context: context,
      ),
      backgroundColor: ColorName.primary,
      body: CustomContainer(
        child: SingleChildScrollView(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Assets.lottie.loginAnimation.lottie(),
              const Gap(20),
              CustomText(
                text: 'Login',
                style: textTheme.headlineLarge,
              ),
              const Gap(20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: 'Email Address',
                      parametersValidate: 'required',
                      keyboardType: TextInputType.emailAddress,
                      textController: emailCtrl,
                      validators: (value) {
                        if (value != null && EmailValidator.validate(value)) {
                          return null;
                        }
                        return "Please enter a valid email";
                      },
                    ),
                    CustomTextField(
                      labelText: 'Password',
                      parametersValidate: 'required',
                      textController: passwordCtrl,
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      obscureText: !_passwordVisible,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        child: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: CustomTextLink(
                          style: const TextStyle(
                            color: ColorName.primary,
                          ),
                          text: "Forgot Password",
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ForgotPasswordPage.routeName);
                          },
                        ),
                      ),
                    ),
                    const Gap(25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CustomBtn(label: 'Login', onTap: handleSubmit),
                    ),
                    const Gap(25),
                    CustomTextLink(
                      style: const TextStyle(
                        color: ColorName.primary,
                      ),
                      text: "Create Account? Signup here",
                      onTap: () {
                        Navigator.of(context).pushNamed(SignUpPage.routeName);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}
