import 'package:flutter/material.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';

class CommonBtnChip extends StatelessWidget {
  const CommonBtnChip({
    Key? key,
    required this.title,
    required this.onTap,
    required this.enable,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: enable ? ColorName.primary : ColorName.secondary,
        ),
        child: CustomText(
          text: title,
          style: textTheme.labelLarge?.copyWith(
            color: enable ? Colors.white : ColorName.primary,
          ),
        ),
      ),
    );
  }
}
