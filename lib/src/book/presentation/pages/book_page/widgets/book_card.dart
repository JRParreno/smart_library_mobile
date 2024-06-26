import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:smart_libary_app/core/common_widget/custom_text.dart';
import 'package:smart_libary_app/core/extensions/popularity_str.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/book/domain/entities/book.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.book,
    required this.onTap,
  }) : super(key: key);

  final Book book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.40,
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                book.coverPhoto,
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: book.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(5),
                    CustomText(
                      text: book.author,
                      style: textTheme.labelMedium
                          ?.copyWith(color: ColorName.placeHolder),
                    ),
                    const Gap(5),
                    CustomText(
                      text: 'Year: ${book.year}',
                      style: textTheme.labelMedium
                          ?.copyWith(color: ColorName.placeHolder),
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: ColorName.placeHolder,
                            ),
                            CustomText(
                              text: book.totalRate.toStringAsFixed(2),
                              style: textTheme.labelMedium
                                  ?.copyWith(color: ColorName.placeHolder),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.flame_fill,
                              size: 14,
                              color: ColorName.placeHolder,
                            ),
                            const Gap(2),
                            CustomText(
                              text: book.popularity.toKMBGenerator(),
                              style: textTheme.labelMedium
                                  ?.copyWith(color: ColorName.placeHolder),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
