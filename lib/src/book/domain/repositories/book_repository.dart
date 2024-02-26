import 'package:smart_libary_app/src/book/data/models/book_model.dart';

abstract class BookRepository {
  Future<BookModel> getBooks({
    String? nextPage,
  });
}
