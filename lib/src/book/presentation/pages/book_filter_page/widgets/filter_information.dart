import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';

class FilterInformation extends StatelessWidget {
  const FilterInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            color: ColorName.primary,
            width: 0.5,
          ),
        ),
        surfaceTintColor: ColorName.primary,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.info),
              Gap(5),
              Expanded(
                child: CustomText(
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
