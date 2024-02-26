import 'package:smart_libary_app/core/config/app_constant.dart';
import 'package:smart_libary_app/core/interceptor/api_interceptor.dart';
import 'package:smart_libary_app/src/book/data/models/book_model.dart';
import 'package:smart_libary_app/src/book/domain/entities/book.dart';
import 'package:smart_libary_app/src/book/domain/repositories/book_repository.dart';

class BookRepositoryImpl extends BookRepository {
  @override
  Future<BookModel> getBooks({String? nextPage}) async {
    String url = nextPage ?? '${AppConstant.apiUrl}/book-list';

    return await ApiInterceptor.apiInstance()
        .get(
      url,
    )
        .then((value) {
      final results = value.data['results'] as List<dynamic>;

      final books = results.map((e) => Book.fromMap(e)).toList();
      return BookModel(
          books: books,
          nextPage: value.data['next'],
          totalCount: value.data['count']);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
