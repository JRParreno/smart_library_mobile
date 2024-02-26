import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_libary_app/core/bloc/profile/profile_bloc.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/core/config/app_constant.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/screens/change_password_screen.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/screens/update_account_screen.dart';

class MenuOptions extends StatelessWidget {
  final BuildContext ctx;
  const MenuOptions({
    super.key,
    required this.ctx,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(
                  color: ColorName.primary,
                ),
              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: const CustomText(text: 'Update Account'),
                leading: const Icon(Icons.person),
                onTap: () {
                  toNavigateScreen(
                    routeName: UpdateAccountScreen.routeName,
                    context: context,
                  );
                },
                trailing: const Icon(Icons.chevron_right),
                enableFeedback: true,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(
                  color: ColorName.primary,
                ),
              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: const CustomText(text: 'Change Password'),
                leading: const Icon(Icons.visibility_off),
                onTap: () {
                  toNavigateScreen(
                    routeName: ChangePasswordScreen.routeName,
                    context: context,
                  );
                },
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(
                  color: ColorName.primary,
                ),
              ),
              margin: const EdgeInsets.only(bottom: 1),
              child: ListTile(
                title: const CustomText(text: 'Logout'),
                leading: const Icon(Icons.logout),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const CustomText(text: AppConstant.appName),
                    content: const Text('Are you sure? you want to logout?.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const CustomText(text: 'Cancel'),
                      ),
                      TextButton(
                        onPressed: () => {handleLogout(context)},
                        child: const CustomText(
                          text: 'OK',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toNavigateScreen(
      {required BuildContext context, required String routeName}) {
    Navigator.of(context).pushNamed(routeName);
  }

  void handleLogout(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(SetProfileLogoutEvent());
    Navigator.pop(context);
  }
}
