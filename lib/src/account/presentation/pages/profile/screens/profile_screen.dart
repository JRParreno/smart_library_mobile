import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smart_libary_app/core/bloc/profile/profile_bloc.dart';
import 'package:smart_libary_app/core/local_storage/local_storage.dart';
import 'package:smart_libary_app/src/account/presentation/pages/profile/widgets/menu_options.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final profile = state.profile;

          return Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.network(
                  profile.profilePhoto ??
                      'https://media.istockphoto.com/id/1327592449/vector/default-avatar-photo-placeholder-icon-grey-profile-picture-business-man.jpg?s=612x612&w=0&k=20&c=yqoos7g9jmufJhfkbQsk-mdhKEsih6Di4WZ66t_ib7I=',
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(30),
              MenuOptions(
                ctx: context,
                logout: handleLogout,
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  void handleLogout() async {
    await LocalStorage.deleteLocalStorage('_user');
    await LocalStorage.deleteLocalStorage('_token');
    await LocalStorage.deleteLocalStorage('_refreshToken');

    if (mounted) {
      BlocProvider.of<ProfileBloc>(context).add(SetProfileLogoutEvent());
      Navigator.pop(context);
    }
  }
}
