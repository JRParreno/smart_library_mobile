import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:smart_libary_app/core/bloc/profile/profile_bloc.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/screens/profile_screen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/unauthorize/unauthorize_page.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/book_page.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_saved_page/book_saved_page.dart';
import 'package:smart_libary_app/src/book/presentation/pages/search_book_page/search_book_page.dart';
import 'package:smart_libary_app/src/home/presentation/widgets/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  String appBarTitle = 'Smart Libary';

  final labels = [
    "Smart Libary",
    "Saved Books",
    "Search",
    "Profile",
    "About",
  ];

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );

    handleOnChangeTabBar();
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        showBackBtn: true,
        title: appBarTitle,
      ),
      backgroundColor: ColorName.primary,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: CustomContainer(
          padding: _motionTabBarController?.index == 3 ? EdgeInsets.zero : null,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return TabBarView(
                physics:
                    const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
                controller: _motionTabBarController,
                children: <Widget>[
                  const BookPage(),
                  state is ProfileLoaded
                      ? const BookSavedPage()
                      : const UnauthorizePage(),
                  const SearchBookPage(),
                  state is ProfileLoaded
                      ? const ProfileScreen()
                      : const UnauthorizePage(),
                  MainPageContentComponent(
                      title: "Settings Page",
                      controller: _motionTabBarController!),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        labels: labels,
        onChangedNav: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
        motionTabBarController: _motionTabBarController,
        initialSelectedTab: labels[0],
      ),
    );
  }

  void handleOnChangeTabBar() {
    if (_motionTabBarController != null) {
      _motionTabBarController!.addListener(() {
        setState(() {
          appBarTitle = labels[_motionTabBarController!.index];
        });
      });
    }
  }
}

class MainPageContentComponent extends StatelessWidget {
  const MainPageContentComponent({
    required this.title,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final String title;
  final MotionTabBarController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          const Text('Go to "X" page programmatically'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => controller.index = 0,
            child: const Text('Dashboard Page'),
          ),
          ElevatedButton(
            onPressed: () => controller.index = 1,
            child: const Text('Home Page'),
          ),
          ElevatedButton(
            onPressed: () => controller.index = 2,
            child: const Text('Settings Page'),
          ),
        ],
      ),
    );
  }
}
