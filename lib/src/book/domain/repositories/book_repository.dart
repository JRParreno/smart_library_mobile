import 'package:smart_libary_app/src/book/data/models/book_filter_model.dart';
import 'package:smart_libary_app/src/book/data/models/book_model.dart';
import 'package:smart_libary_app/src/book/domain/entities/book.dart';

abstract class BookRepository {
  Future<BookModel> getBooks({
    String? nextPage,
  });

  Future<BookModel> getSearchBooks({
    required String search,
    required BookFilterModel filters,
    String? nextPage,
  });

  Future<Book> getDetailBook(int bookPk);

  Future<void> rateBook({
    required int rate,
    required int bookPk,
  });

  Future<void> saveBook(int bookPk);

  Future<BookModel> getSaveBook();

  Future<void> deleteSaveBook(int savePk);

  Future<void> viewCountEvent(int bookPk);
}
