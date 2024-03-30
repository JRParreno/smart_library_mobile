import 'package:flutter/material.dart';
import 'package:rate/rate.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';

class RateFilter extends StatelessWidget {
  const RateFilter({
    Key? key,
    required this.rate,
    required this.onChange,
    required this.isShow,
  }) : super(key: key);

  final double rate;
  final Function(double value) onChange;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Rate',
          style: TextStyle(
            color: ColorName.placeHolder,
          ),
        ),
        if (isShow) ...[
          Rate(
            initialValue: rate,
            onChange: (value) {
              onChange(value);
            },
            allowHalf: false,
            allowClear: true,
            color: ColorName.primary,
            iconSize: 35,
          ),
        ] else ...[
          const CircularProgressIndicator(
            strokeWidth: 0.5,
          )
        ]
      ],
    );
  }
}
