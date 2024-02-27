import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:gap/gap.dart';
import 'package:smart_libary_app/core/bloc/profile/profile_bloc.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/gen/assets.gen.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/data/datasources/login_repository_impl.dart';
import 'package:smart_libary_app/src/account/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:smart_libary_app/src/account/presentation/pages/login/bloc/login_bloc.dart';
import 'package:smart_libary_app/src/account/presentation/pages/signup/signup_page.dart';
import 'package:smart_libary_app/src/home/presentation/home.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();

    loginBloc = LoginBloc(LoginRepositoryImpl());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => loginBloc,
      child: Scaffold(
        appBar: buildAppBar(
          context: context,
        ),
        backgroundColor: ColorName.primary,
        body: ProgressHUD(
          child: Builder(builder: (context) {
            final progressHUD = ProgressHUD.of(context);

            return CustomContainer(
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    progressHUD?.show();
                  }

                  if (state is LoginSuccess || state is LoginError) {
                    progressHUD?.dismiss();

                    if (state is LoginSuccess) {
                      handleNavigate();
                    }

                    if (state is LoginError) {
                      handleErrorMessage(state.errorMessage);
                    }
                  }
                },
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
                                if (value != null &&
                                    EmailValidator.validate(value)) {
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
                                    Navigator.of(context).pushNamed(
                                        ForgotPasswordPage.routeName);
                                  },
                                ),
                              ),
                            ),
                            const Gap(25),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: CustomBtn(
                                  label: 'Login', onTap: handleSubmit),
                            ),
                            const Gap(25),
                            CustomTextLink(
                              style: const TextStyle(
                                color: ColorName.primary,
                              ),
                              text: "Create Account? Signup here",
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(SignUpPage.routeName);
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
          }),
        ),
      ),
    );
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      loginBloc.add(
        OnSubmitLoginEvent(
          emailAddress: emailCtrl.value.text,
          password: passwordCtrl.value.text,
        ),
      );
    }
  }

  void handleErrorMessage(String errorMessage) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: errorMessage,
      ),
    );
  }

  void handleNavigate() {
    BlocProvider.of<ProfileBloc>(context).add(OnGetProfileEvent());
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage()),
      ModalRoute.withName('/'),
    );
  }
}
