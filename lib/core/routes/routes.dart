import 'package:flutter/material.dart';
import 'package:smart_libary_app/src/about/about_page.dart';
import 'package:smart_libary_app/src/account/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:smart_libary_app/src/account/presentation/pages/login/login_page.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/screens/change_password_screen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/screens/profile_screen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/screens/update_account_screen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/screens/update_profile_picture_screen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/signup/signup_page.dart';
import 'package:smart_libary_app/src/account/presentation/pages/unauthorize/unauthorize_page.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_detail_page/book_detail_page.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_filter_page/book_filter_page.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/book_page.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_saved_page/book_saved_page.dart';
import 'package:smart_libary_app/src/book/presentation/pages/search_book_page/search_book_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      switch (settings.name) {
        case BookPage.routeName:
          return const BookPage();
        case BookDetailPage.routeName:
          final args = settings.arguments! as BookDetailPageArgs;
          return BookDetailPage(
            args: args,
          );
        case BookSavedPage.routeName:
          return const BookSavedPage();
        case UnauthorizePage.routeName:
          return const UnauthorizePage();
        case LoginPage.routeName:
          return const LoginPage();
        case ForgotPasswordPage.routeName:
          return const ForgotPasswordPage();
        case SignUpPage.routeName:
          return const SignUpPage();
        case ProfileScreen.routeName:
          return const ProfileScreen();
        case UpdateProfilePcitureScreen.routeName:
          return const UpdateProfilePcitureScreen();
        case ChangePasswordScreen.routeName:
          return const ChangePasswordScreen();
        case UpdateAccountScreen.routeName:
          return const UpdateAccountScreen();
        case SearchBookPage.routeName:
          return const SearchBookPage();
        case BookFilterPage.routeName:
          final args = settings.arguments! as BookFilterArgs;
          return BookFilterPage(
            args: args,
          );
        case AboutPage.routeName:
          return const AboutPage();
      }

      return const Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Text('Something went wrong'),
        ),
      );
    },
  );
}
