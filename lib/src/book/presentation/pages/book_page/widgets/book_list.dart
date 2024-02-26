import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:smart_libary_app/src/book/domain/entities/book.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_detail_page/book_detail_page.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_card.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_list_loading.dart';

class BookList extends StatelessWidget {
  const BookList({
    Key? key,
    required this.books,
    this.isPaginate = false,
  }) : super(key: key);

  final List<Book> books;
  final bool isPaginate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: books.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 6 / 10.0,
            crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
            mainAxisSpacing: MediaQuery.of(context).size.width * 0.05,
          ),
          itemBuilder: (context, index) {
            final book = books[index];
            return Column(
              children: [
                BookCard(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      BookDetailPage.routeName,
                      arguments: BookDetailPageArgs(
                        book: book,
                      ),
                    );
                  },
                  book: book,
                ),
              ],
            );
          },
        ),
        if (isPaginate) ...[
          const Gap(15),
          const BookListLoading(itemCount: 2),
        ]
      ],
    );
  }
}
