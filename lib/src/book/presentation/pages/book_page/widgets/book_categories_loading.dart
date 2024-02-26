import 'package:flutter/material.dart';
import 'package:smart_libary_app/core/common_widget/common_btn_chip.dart';
import 'package:smart_libary_app/core/common_widget/shimmer.dart';
import 'package:smart_libary_app/core/config/app_constant.dart';

class BookCategoriesLoading extends StatelessWidget {
  const BookCategoriesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Shimmer(
              linearGradient: AppConstant.shimmerGradient,
              child: ShimmerLoading(
                isLoading: true,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: CommonBtnChop(title: 'Loading', onTap: () {}),
                ),
              ),
            );
          },
        ));
  }
}
