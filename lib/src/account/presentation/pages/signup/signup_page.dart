import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:smart_libary_app/core/bloc/profile/profile_bloc.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/data/datasources/signup_repository_impl.dart';
import 'package:smart_libary_app/src/account/data/models/signup_model.dart';
import 'package:smart_libary_app/src/account/presentation/pages/signup/bloc/signup_bloc.dart';
import 'package:smart_libary_app/src/account/presentation/pages/signup/widgets/signup_form.dart';
import 'package:smart_libary_app/src/home/presentation/home.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/account/signup';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController genderCtrl = TextEditingController();
  late SignupBloc signupBloc;

  final signupFormKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  bool _isCheck = false;

  @override
  void initState() {
    super.initState();
    // handleTest();
    signupBloc = SignupBloc(SignupRepositoryImpl());
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => signupBloc,
      child: Scaffold(
        backgroundColor: ColorName.primary,
        appBar: buildAppBar(context: context, title: "Signup"),
        body: ProgressHUD(
          child: Builder(
            builder: (context) {
              final progressHUD = ProgressHUD.of(context);

              return CustomContainer(
                child: BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileLoading) {
                      progressHUD?.show();
                    }

                    if (state is ProfileLoaded || state is ProfileError) {
                      progressHUD?.dismiss();

                      if (state is ProfileLoaded) {
                        handleNavigate();
                      }

                      if (state is ProfileError) {
                        handleErrorMessage(state.errorMessage);
                      }
                    }
                  },
                  child: BlocListener<SignupBloc, SignupState>(
                    listener: (ctx, state) {
                      if (state is SignupLoading) {
                        progressHUD?.show();
                      }

                      if (state is SignupSuccess || state is SignupError) {
                        progressHUD?.dismiss();

                        if (state is SignupSuccess) {
                          handleGetProfile();
                        }

                        if (state is SignupError) {
                          handleErrorMessage(state.errorMessage);
                        }
                      }
                    },
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: SignupForm(
                        emailCtrl: emailCtrl,
                        passwordCtrl: passwordCtrl,
                        confirmPasswordCtrl: confirmPasswordCtrl,
                        firstNameCtrl: firstNameCtrl,
                        lastNameCtrl: lastNameCtrl,
                        signupFormKey: signupFormKey,
                        passwordVisible: _passwordVisible,
                        confirmPasswordVisible: _confirmPasswordVisible,
                        genderCtrl: genderCtrl,
                        onSelectGender: (value) {
                          genderCtrl.value = TextEditingController.fromValue(
                                  TextEditingValue(text: value))
                              .value;
                        },
                        suffixIconPassword: GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Icon(!_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        suffixIconConfirmPassword: GestureDetector(
                          onTap: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                          child: Icon(!_confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        onChangeCheckBox: (value) {
                          setState(() {
                            _isCheck = value;
                          });
                        },
                        isCheck: _isCheck,
                        onSubmit: handleSubmit,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void handleTest() {
    firstNameCtrl.text = 'Jhon Rhay';
    lastNameCtrl.text = 'Parreno';
    emailCtrl.text = 'jhonrhayparreno22@gmail.com';
    genderCtrl.text = 'male';
    passwordCtrl.text = '2020Rtutest@';
    confirmPasswordCtrl.text = '2020Rtutest@';
  }

  void handleSubmit() {
    if (signupFormKey.currentState!.validate()) {
      final signupModel = SignupModel(
        firstName: firstNameCtrl.value.text,
        lastName: lastNameCtrl.value.text,
        email: emailCtrl.value.text,
        gender: genderCtrl.text.toLowerCase() == 'male' ? "M" : "F",
        password: passwordCtrl.value.text,
        confirmPassword: confirmPasswordCtrl.value.text,
      );
      signupBloc.add(OnSignupSubmit(signupModel: signupModel));
    }
  }

  void handleGetProfile() {
    BlocProvider.of<ProfileBloc>(context).add(OnGetProfileEvent());
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
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage()),
      ModalRoute.withName('/'),
    );
  }
}
