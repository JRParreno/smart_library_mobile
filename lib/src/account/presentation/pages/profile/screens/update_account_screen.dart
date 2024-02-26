import 'package:flutter/material.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/widgets/update_account/update_account_form.dart';

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
  final formKey = GlobalKey<FormState>();
  String linkTitle = "You account is not verified yet. click here to verify.";

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      // EasyLoading.show();
      // ProfileRepositoryImpl()
      //     .updateProfile(
      //   email: emailCtrl.text,
      //   firstName: firstNameCtrl.text,
      //   lastName: lastNameCtrl.text,
      // )
      //     .then((value) {
      //   BlocProvider.of<ProfileBloc>(context)
      //       .add(SetProfileEvent(profile: value));
      //   showDialogReport("Successfully udpate your account!");
      // }).catchError((onError) {
      //   EasyLoading.dismiss();
      //   final DioException error = onError as DioException;
      //   if (error.response != null) {
      //     final response = error.response!.data;
      //     showDialogReport(response['error_message']);
      //   }
      // }).whenComplete(() {
      //   EasyLoading.dismiss();
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      appBar: buildAppBar(context: context, title: "Account"),
      body: CustomContainer(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: UpdateAccountForm(
            emailCtrl: emailCtrl,
            lastNameCtrl: lastNameCtrl,
            firstNameCtrl: firstNameCtrl,
            formKey: formKey,
            onSubmit: handleSubmit,
          ),
        ),
      ),
    );
  }
}
