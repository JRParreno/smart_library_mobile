import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_libary_app/core/bloc/profile/profile_bloc.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
            body: ProgressHUD(
              child: Builder(builder: (context) {
                final progressHUD = ProgressHUD.of(context);

                return BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileLoaded) {
                      if (state.isLoading) {
                        progressHUD?.show();
                        return;
                      }

                      progressHUD?.dismiss();
                      if (state.errorMessage == null) {
                        handleSuccessMessage(
                            'Successfully change your profile photo!');
                        return;
                      }
                      handleErrorMessage(state.errorMessage ?? '');
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: image != null
                                ? Image.file(File(image!.path))
                                : profile.profilePhoto != null
                                    ? Image(
                                        image:
                                            NetworkImage(profile.profilePhoto!))
                                    : Image.network(
                                        profile.profilePhoto ??
                                            'https://media.istockphoto.com/id/1327592449/vector/default-avatar-photo-placeholder-icon-grey-profile-picture-business-man.jpg?s=612x612&w=0&k=20&c=yqoos7g9jmufJhfkbQsk-mdhKEsih6Di4WZ66t_ib7I=',
                                        fit: BoxFit.contain,
                                      ),
                          ),
                          CustomBtn(
                            label: "Choose from Gallery",
                            backgroundColor: Colors.blue[400],
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? pickImage = await picker.pickImage(
                                  source: ImageSource.gallery);
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
                    );
                  },
                );
              }),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  void handleSubmitPhoto() {
    if (image != null) {
      context.read<ProfileBloc>().add(
            OnChangePictureProfileEvent(image!.path),
          );
    }
  }

  void handleErrorMessage(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: message,
      ),
    );
  }

  void handleSuccessMessage(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
      ),
    );
  }
}
