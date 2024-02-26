import 'package:flutter/material.dart';

import 'package:smart_libary_app/core/widgets/text/custom_text_field.dart';

class BookSearch extends StatelessWidget {
  const BookSearch({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              hintText: 'Search..',
              controller: textEditingController,
              onSubmitted: (value) {},
            ),
          ),
          const Icon(Icons.filter),
        ],
      ),
    );
  }
}
