import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/book/domain/entities/book.dart';

class MoreDetailsSection extends StatelessWidget {
  final Book book;
  final bool isShowInfo;
  final VoidCallback onTapView;

  const MoreDetailsSection({
    Key? key,
    required this.book,
    required this.onTapView,
    required this.isShowInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: onTapView,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(
                  child: Divider(
                    color: ColorName.placeHolder,
                    endIndent: 5,
                  ),
                ),
                CustomText(
                  text: '${isShowInfo ? 'Hide' : 'View'} Additional Info',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const Expanded(
                  child: Divider(
                    color: ColorName.placeHolder,
                    indent: 5,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          if (isShowInfo) ...[
            if (book.controlNumber != null) ...[
              richText(
                title: "Control No.: ",
                description: book.controlNumber!,
              ),
              const Gap(8),
            ],
            if (book.callNumber != null) ...[
              richText(
                title: "Call No.: ",
                description: book.callNumber!,
              ),
              const Gap(8),
            ],
            richText(
              title: "General Information: ",
              description: book.generalInformation,
            ),
            const Gap(8),
            if (book.imprint != null) ...[
              richText(
                title: "Imprint: ",
                description: book.imprint!,
              ),
            ],
            richText(
              title: "Physical Description: ",
              description: book.physicalDescription,
            ),
            const Gap(8),
            richText(
              title: "Edition Statement: ",
              description: book.editionStatement,
            ),
            const Gap(8),
            richText(
              title: "Subject: ",
              description: book.tags.map((e) => e.name).toList().join('--'),
            ),
            const Gap(8),
            if (book.discipline != null) ...[
              richText(
                title: "Discipline: ",
                description: book.discipline!,
              ),
              const Gap(8),
            ],
            richText(
              title: "DDC No.: ",
              description: book.ddcNumber,
            ),
            const Gap(8),
          ],
        ],
      ),
    );
  }

  Widget richText({required String title, required String description}) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        text: title,
        style: const TextStyle(
          letterSpacing: 0.5,
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        children: <TextSpan>[
          TextSpan(
            text: description,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
