import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:smart_libary_app/core/bloc/profile/profile_bloc.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/widgets/update_account/update_account_form.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UpdateAccountScreen extends StatefulWidget {
  static const String routeName = 'update-account';

  const UpdateAccountScreen({super.key});

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController genderCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String linkTitle = "You account is not verified yet. click here to verify.";

  @override
  void initState() {
    super.initState();
    initForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      appBar: buildAppBar(context: context, title: "Account"),
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
                    handleSuccessMessage('Successfully update your account!');
                    return;
                  }
                  handleErrorMessage(state.errorMessage ?? '');
                }
              },
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  return SingleChildScrollView(
                    child: UpdateAccountForm(
                      genderCtrl: genderCtrl,
                      emailCtrl: emailCtrl,
                      lastNameCtrl: lastNameCtrl,
                      firstNameCtrl: firstNameCtrl,
                      formKey: formKey,
                      onSubmit: handleSubmit,
                      onSelectGender: (value) {
                        genderCtrl.value = TextEditingController.fromValue(
                                TextEditingValue(text: value))
                            .value;
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            );
          }),
        ),
      ),
    );
  }

  void initForm() {
    final profileState = context.read<ProfileBloc>().state;

    if (profileState is ProfileLoaded) {
      final profile = profileState.profile;
      firstNameCtrl.text = profile.firstName;
      lastNameCtrl.text = profile.lastName;
      emailCtrl.text = profile.email;
      genderCtrl.text = profile.gender.toLowerCase() == "m" ? "Male" : "Female";
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

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            OnUpdateProfileEvent(
              firstName: firstNameCtrl.value.text,
              lastName: lastNameCtrl.value.text,
              email: emailCtrl.value.text,
              gender: genderCtrl.text.toLowerCase() == 'male' ? "M" : "F",
            ),
          );
    }
  }
}
