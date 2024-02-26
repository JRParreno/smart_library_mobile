import 'package:flutter/material.dart';

import 'package:smart_libary_app/core/common_widget/shimmer.dart';
import 'package:smart_libary_app/core/config/app_constant.dart';
import 'package:smart_libary_app/src/book/domain/entities/book.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_card.dart';

class BookListLoading extends StatelessWidget {
  const BookListLoading({
    Key? key,
    this.itemCount,
  }) : super(key: key);

  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount ?? 15,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 6 / 10.0,
          crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
          mainAxisSpacing: MediaQuery.of(context).size.width * 0.05,
        ),
        itemBuilder: (context, index) {
          return Shimmer(
            linearGradient: AppConstant.shimmerGradient,
            child: ShimmerLoading(
              isLoading: true,
              child: BookCard(
                book: Book.empty(),
                onTap: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
