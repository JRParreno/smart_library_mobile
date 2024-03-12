import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:smart_libary_app/core/common_widget/common_widget.dart';
import 'package:smart_libary_app/src/book/domain/entities/book.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_detail_page/book_detail_page.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_list.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_list_loading.dart';
import 'package:smart_libary_app/src/home/presentation/bloc/home_book/home_book_bloc.dart';

class BookSection extends StatelessWidget {
  const BookSection({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            text: 'Books',
            style: themeContext.titleLarge,
          ),
          const Gap(10),
          Expanded(
            child: BlocBuilder<HomeBookBloc, HomeBookState>(
              builder: (context, state) {
                if (state is HomeBookError) {
                  return const SizedBox(
                      width: double.infinity,
                      child: CustomText(text: 'Something went wrong'));
                }
                if (state is HomeBookLoaded) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: BookList(
                      books: state.bookModel.books,
                      isPaginate: state.isPaginate,
                      onTapBook: (book) =>
                          handleOnTapBook(book: book, context: context),
                    ),
                  );
                }
                return const BookListLoading();
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleOnTapBook({
    required Book book,
    required BuildContext context,
  }) {
    Navigator.of(context).pushNamed(
      BookDetailPage.routeName,
      arguments: BookDetailPageArgs(
        book: book,
      ),
    );
  }
}
