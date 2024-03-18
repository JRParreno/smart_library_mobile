import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/gen/assets.gen.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/about/widgets/mini_profile_card.dart';

class AboutPage extends StatefulWidget {
  static const String routeName = 'about/';

  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: ColorName.primary,
                  width: 4,
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text:
                    'SMART LIBRARY BOOK RECOMMENDATION SYSTEM USING COLLABORATIVE FILTERING',
                style: TextStyle(color: Colors.black.withOpacity(0.75)),
              ),
            ),
          ),
          MiniProfileCard(
            imagePath: Assets.devs.aaron.path,
            name: 'Aaron July Aguilar',
            role: 'Fullstack Developer',
            emailAddress: 'aguilar.aaronjuly0730@gmail.com',
            fb: 'https://www.facebook.com/aaron.j.aguilar?mibextid=ZbWKwL',
            mobileNumber: '09557627690',
          ),
          const Gap(10),
          MiniProfileCard(
            imagePath: Assets.devs.kyle.path,
            name: 'Kyle Jerichoo Belmonte',
            role: 'Backend Developer',
            emailAddress: 'kaylbelmonte15@gmail.com',
            fb: 'https://www.facebook.com/profile.php?id=100075035741410',
            mobileNumber: '09517650942',
          ),
          const Gap(10),
          MiniProfileCard(
            imagePath: Assets.devs.stven.path,
            name: 'Steven Mari Bernaldez',
            role: 'Fullstack Developer',
            emailAddress: 'bernaldezstevenmarib@gmail.com',
            fb: 'https://www.facebook.com/stevenbernaldez',
            mobileNumber: '09165873211',
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
