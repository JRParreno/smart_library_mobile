import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:gap/gap.dart';
import 'package:rate/rate.dart';
import 'package:smart_libary_app/core/common_widget/common_widget.dart';

import 'package:smart_libary_app/core/common_widget/custom_appbar.dart';
import 'package:smart_libary_app/core/common_widget/custom_container.dart';
import 'package:smart_libary_app/core/config/app_constant.dart';
import 'package:smart_libary_app/gen/colors.gen.dart';
import 'package:smart_libary_app/src/book/domain/entities/book.dart';

class BookDetailPageArgs {
  final Book book;

  BookDetailPageArgs({
    required this.book,
  });
}

class BookDetailPage extends StatefulWidget {
  static const String routeName = '/book/detail';
  final BookDetailPageArgs args;

  const BookDetailPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late Book book = widget.args.book;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: ColorName.primary,
      appBar: buildAppBar(
        context: context,
        title: book.title,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.bookmark_add),
      ),
      body: CustomContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(
                  book.coverPhoto ?? AppConstant.defaultPhoto,
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(15),
              if (book.bookPhotos.isNotEmpty) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Book Gallery',
                      style: textTheme.titleLarge,
                    ),
                    const Gap(5),
                    GalleryImage(
                      imageUrls: book.bookPhotos,
                      numOfShowImages: 3,
                      titleGallery: 'Book Images',
                    ),
                  ],
                ),
              ],
              const Gap(15),
              CustomText(
                text: 'ISO: ${book.iso.toString()}',
                style: textTheme.titleLarge,
              ),
              const Gap(15),
              Row(
                children: [
                  CustomText(
                    text: 'Rating: ',
                    style: textTheme.titleLarge,
                  ),
                  Rate(
                    iconSize: 25,
                    color: Colors.green,
                    allowHalf: true,
                    allowClear: true,
                    initialValue: book.rate,
                    readOnly: true,
                    // onChange: (value) => print(value),
                  ),
                ],
              ),
              const Gap(15),
              CustomText(
                text: 'Description',
                style: textTheme.titleLarge,
              ),
              const Gap(5),
              CustomText(text: book.description),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
