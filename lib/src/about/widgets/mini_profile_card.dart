import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:smart_libary_app/core/common_widget/custom_text.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class MiniProfileCard extends StatelessWidget {
  const MiniProfileCard({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.role,
    required this.emailAddress,
    required this.mobileNumber,
    required this.fb,
  }) : super(key: key);

  final String name;
  final String imagePath;
  final String role;
  final String emailAddress;
  final String mobileNumber;
  final String fb;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        height: 280,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
              height: 280,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    color: ColorName.primary,
                    height: 100,
                    width: double.infinity,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          const Gap(50),
                          CustomText(
                            text: name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorName.primary,
                              fontSize: 20,
                            ),
                          ),
                          CustomText(
                            text: role,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: handleOnTapEmail,
                                    child: const Icon(
                                      Icons.email,
                                    ),
                                  ),
                                  const Gap(20),
                                  InkWell(
                                    onTap: handleOnTapFB,
                                    child: const Icon(
                                      Icons.facebook,
                                    ),
                                  ),
                                  const Gap(20),
                                  InkWell(
                                    onTap: handleOnTapMobileNumner,
                                    child: const Icon(
                                      Icons.phone,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.29,
              top: 30,
              child: CircleAvatar(
                backgroundImage: Image.asset(
                  imagePath,
                ).image,
                maxRadius: 60,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(60)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleOnTapEmail() {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: encodeQueryParameters(<String, String>{
        'subject': 'SMART LIBRARY SYSTEM SUBJECT',
      }),
    );

    launchUrl(emailLaunchUri);
  }

  void handleOnTapMobileNumner() {
    final Uri smsLaunchUri = Uri(
      scheme: 'tel',
      path: mobileNumber,
    );
    launchUrl(smsLaunchUri);
  }

  Future<void> handleOnTapFB() async {
    final Uri url = Uri.parse(fb);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
