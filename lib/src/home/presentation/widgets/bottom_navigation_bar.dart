import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

import 'package:smart_libary_app/gen/colors.gen.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    Key? key,
    this.motionTabBarController,
    required this.onChangedNav,
    required this.labels,
    required this.initialSelectedTab,
  }) : super(key: key);

  final MotionTabBarController? motionTabBarController;
  final Function(int value) onChangedNav;
  final List<String> labels;
  final String initialSelectedTab;

  @override
  Widget build(BuildContext context) {
    return MotionTabBar(
      controller:
          motionTabBarController, // Add this controller if you need to change your tab programmatically
      initialSelectedTab: initialSelectedTab,
      useSafeArea: true, // default: true, apply safe area wrapper
      labels: labels,
      icons: const [
        Icons.home,
        Icons.bookmark,
        Icons.search,
        Icons.person,
        Icons.info_sharp,
      ],

      // optional badges, length must be same with labels
      badges: const [
        null,
        null,
        null,
        null,
        null,
      ],
      tabSize: 50,
      tabBarHeight: 55,
      textStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      tabIconColor: ColorName.primary.withOpacity(0.75),
      tabIconSize: 28.0,
      tabIconSelectedSize: 26.0,
      tabSelectedColor: ColorName.secondary,
      tabIconSelectedColor: ColorName.primary,
      tabBarColor: Colors.white,
      onTabItemSelected: (int value) {
        onChangedNav(value);
      },
    );
  }
}
