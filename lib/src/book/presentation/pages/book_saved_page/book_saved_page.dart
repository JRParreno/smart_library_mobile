import 'package:flutter/material.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';

class BookSavedPage extends StatefulWidget {
  static const String routeName = '/book/saved';

  const BookSavedPage({super.key});

  @override
  State<BookSavedPage> createState() => _BookSavedPageState();
}

class _BookSavedPageState extends State<BookSavedPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(text: 'Saved Books'),
    );
  }
}
