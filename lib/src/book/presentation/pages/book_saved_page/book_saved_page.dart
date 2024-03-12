import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_libary_app/src/book/data/datasources/book_repository_impl.dart';
import 'package:smart_libary_app/src/book/domain/entities/book.dart';
import 'package:smart_libary_app/src/book/presentation/blocs/saved_book/saved_book_bloc.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_detail_page/book_detail_page.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_list.dart';
import 'package:smart_libary_app/src/book/presentation/pages/book_page/widgets/book_list_loading.dart';

import '../../../../../core/common_widget/common_widget.dart';

class BookSavedPage extends StatefulWidget {
  static const String routeName = '/book-saved';
  const BookSavedPage({super.key});

  @override
  State<BookSavedPage> createState() => _BookSavedPageState();
}

class _BookSavedPageState extends State<BookSavedPage> {
  final ScrollController scrollController = ScrollController();
  late SavedBookBloc savedBookBloc;

  @override
  void initState() {
    super.initState();

    savedBookBloc = SavedBookBloc(BookRepositoryImpl());

    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => savedBookBloc..add(OnGetSavedBookEvent()),
      child: BlocBuilder<SavedBookBloc, SavedBookState>(
        builder: (context, state) {
          if (state is SavedBookError) {
            return const SizedBox(
                width: double.infinity,
                child: CustomText(text: 'Something went wrong'));
          }
          if (state is SavedBookLoaded) {
            if (state.bookModel.books.isEmpty) {
              return const Center(
                child: CustomText(text: 'No Books saved'),
              );
            }
            return SingleChildScrollView(
              controller: scrollController,
              child: BookList(
                books: state.bookModel.books,
                isPaginate: state.isPaginate,
                onTapBook: (book) => handleOnTapBook(book),
              ),
            );
          }
          return const BookListLoading();
        },
      ),
    );
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        savedBookBloc.add(OnPaginateSavedBookEvent());
      }
    });
  }

  void handleOnTapBook(Book book) {
    Navigator.of(context)
        .pushNamed(
      BookDetailPage.routeName,
      arguments: BookDetailPageArgs(
        book: book,
      ),
    )
        .whenComplete(() {
      savedBookBloc.add(OnGetSavedBookEvent());
    });
  }
}
