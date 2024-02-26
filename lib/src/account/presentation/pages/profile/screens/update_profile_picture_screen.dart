import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_libary_app/core/bloc/profile/profile_bloc.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';

class UpdateProfilePcitureScreen extends StatefulWidget {
  static const String routeName = 'update-profile-picture-screen';

  const UpdateProfilePcitureScreen({super.key});

  @override
  State<UpdateProfilePcitureScreen> createState() =>
      _UpdateProfilePcitureScreenState();
}

class _UpdateProfilePcitureScreenState
    extends State<UpdateProfilePcitureScreen> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final profile = state.profile;

          return Scaffold(
            appBar: buildAppBar(context: context, title: "Update Picture"),
            body: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CircleAvatar(
                        backgroundImage: image != null
                            ? Image.file(File(image!.path)).image
                            : profile.profilePhoto != null
                                ? NetworkImage(profile.profilePhoto!)
                                : null,
                        radius: 100,
                        child: profile.profilePhoto != null
                            ? null
                            : const Icon(Icons.person, size: 50),
                      ),
                    ),
                  ),
                  CustomBtn(
                    label: "Choose from Gallery",
                    backgroundColor: Colors.blue[400],
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? pickImage =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        image = pickImage;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomBtn(
                    label: "Save",
                    onTap: image != null ? handleSubmitPhoto : null,
                  )
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  void handleSubmitPhoto() {
    // final profile = ProfileUtils.userProfile(context);

    // if (image != null && profile != null) {
    //   EasyLoading.show();

    //   ProfileRepositoryImpl()
    //       .uploadPhoto(
    //     pk: profile.profilePk,
    //     imagePath: image!.path,
    //   )
    //       .then((value) async {
    //     BlocProvider.of<ProfileBloc>(context).add(
    //       SetProfilePicture(value),
    //     );
    //     showDialogReport("Successfully udpate your profile picture!");
    //   }).catchError((onError) {
    //     EasyLoading.dismiss();
    //     showDialogReport("Something went wrong");
    //   }).whenComplete(() {
    //     EasyLoading.dismiss();
    //   });
    // }
  }
}
