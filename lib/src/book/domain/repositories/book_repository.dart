import 'package:smart_libary_app/src/book/data/models/book_filter_model.dart';
import 'package:smart_libary_app/src/book/data/models/book_model.dart';

abstract class BookRepository {
  Future<BookModel> getBooks({
    String? nextPage,
  });

  Future<BookModel> getSearchBooks({
    required String search,
    required BookFilterModel filters,
    String? nextPage,
  });
}
