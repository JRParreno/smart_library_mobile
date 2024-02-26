import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:smart_libary_app/core/common_widget/common_bottomsheet.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/signup/widgets/gender_select_widget.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key? key,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.confirmPasswordCtrl,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.genderCtrl,
    required this.onSelectGender,
    required this.signupFormKey,
    required this.passwordVisible,
    required this.confirmPasswordVisible,
    this.suffixIconPassword,
    this.suffixIconConfirmPassword,
    this.isCheck = false,
    required this.onChangeCheckBox,
    required this.onSubmit,
  }) : super(key: key);

  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPasswordCtrl;
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController genderCtrl;

  final Function(String value) onSelectGender;
  final GlobalKey<FormState> signupFormKey;
  final bool passwordVisible;
  final bool confirmPasswordVisible;
  final Widget? suffixIconPassword;
  final Widget? suffixIconConfirmPassword;
  final bool isCheck;
  final Function(bool value) onChangeCheckBox;

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signupFormKey,
      child: Column(
        children: [
          CustomTextField(
            textController: firstNameCtrl,
            labelText: "Firstname",
            padding: EdgeInsets.zero,
            parametersValidate: 'required',
          ),
          const Gap(8),
          CustomTextField(
            textController: lastNameCtrl,
            labelText: "Lastname",
            padding: EdgeInsets.zero,
            parametersValidate: 'required',
          ),
          const Gap(8),
          CustomTextField(
            textController: emailCtrl,
            labelText: "Email",
            keyboardType: TextInputType.emailAddress,
            padding: EdgeInsets.zero,
            parametersValidate: 'required',
            validators: (value) {
              if (value != null &&
                  RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w\w+)+$')
                      .hasMatch(value)) {
                return null;
              }
              return 'Invalid email address';
            },
          ),
          CustomTextField(
            textController: genderCtrl,
            labelText: "Gender",
            keyboardType: TextInputType.emailAddress,
            padding: EdgeInsets.zero,
            parametersValidate: 'required',
            readOnly: true,
            onTap: () => commonBottomSheetDialog(
              context: context,
              title: "Select Gender",
              container: GenderSelectWidget(
                onSelectGender: onSelectGender,
                selectedGender:
                    genderCtrl.text.isNotEmpty ? genderCtrl.text : null,
              ),
            ),
          ),
          const Gap(8),
          CustomTextField(
            textController: passwordCtrl,
            labelText: "Password",
            padding: EdgeInsets.zero,
            parametersValidate: 'required',
            suffixIcon: suffixIconPassword,
            obscureText: passwordVisible,
          ),
          const Gap(8),
          CustomTextField(
            textController: confirmPasswordCtrl,
            labelText: "Confirm Password",
            padding: EdgeInsets.zero,
            parametersValidate: 'required',
            suffixIcon: suffixIconConfirmPassword,
            obscureText: confirmPasswordVisible,
            validators: (value) {
              if (value != null &&
                  value.isEmpty &&
                  value != passwordCtrl.value.text) {
                return "Password doesn't match";
              }
              return null;
            },
          ),
          const Gap(20),
          Row(
            children: [
              Checkbox(
                  activeColor: ColorName.primary,
                  value: isCheck,
                  onChanged: (value) {
                    onChangeCheckBox(value ?? false);
                  }),
              const Expanded(
                child: CustomText(
                  text:
                      "By creating you agree to the terms and Use and Privacy Policy",
                ),
              ),
            ],
          ),
          const Divider(
            height: 40,
            color: Colors.transparent,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomBtn(
                label: "Submit",
                onTap: onSubmit,
                width: 275,
              ),
              const Gap(50),
            ],
          )
        ],
      ),
    );
  }
}
