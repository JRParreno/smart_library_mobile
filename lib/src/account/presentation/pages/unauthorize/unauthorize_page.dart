import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/gen/assets.gen.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/login/login_page.dart';
import 'package:smart_libary_app/src/account/presentation/pages/signup/signup_page.dart';

class UnauthorizePage extends StatefulWidget {
  static const String routeName = '/account/unauthorize';

  const UnauthorizePage({super.key});

  @override
  State<UnauthorizePage> createState() => _UnauthorizePageState();
}

class _UnauthorizePageState extends State<UnauthorizePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.25,
                  maxHeight: MediaQuery.of(context).size.height * 0.35),
              child: Assets.lottie.loginAnimation.lottie()),
          const Gap(20),
          CustomText(
            text: 'Hello',
            style: textTheme.headlineLarge,
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                CustomText(
                  text:
                      'Welcome to Smart Libray App, where you can search for books and saved them!',
                  style: textTheme.titleLarge,
                  textAlign: TextAlign.justify,
                ),
                const Gap(40),
                CustomBtn(
                    label: 'Login',
                    onTap: () {
                      handleNavigate(LoginPage.routeName);
                    }),
                const Gap(20),
                CustomBtn(
                  label: 'Signup',
                  onTap: () {
                    handleNavigate(SignUpPage.routeName);
                  },
                  btnStyle: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: ColorName.primary),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                )
              ],
            ),
          ),
          const Gap(50),
        ],
      ),
    );
  }

  void handleNavigate(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}
