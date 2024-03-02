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

  @override
  Future<BookModel> getSearchBooks({
    required String search,
    String? nextPage,
  }) async {
    String initialUrl = '';

    if (nextPage != null) {
      initialUrl = nextPage;
    } else {
      const departmentFields = 'department__acronym,department__name';
      const tagsFields = 'tags__acronym,tags__name';
      final authorValue = 'author=$search';
      final titleValue = 'title=$search';
      final isbnIssnValue = 'isbn_issn=$search';
      final publisherValue = 'publisher=$search';
      final departmenValues =
          'department__acronym=$search&department__name=$search';
      final tagsValues = 'tags__acronym=$search&tags__name=$search';

      initialUrl =
          '${AppConstant.apiUrl}/book-list?search_fields=title,author,isbn_issn,publisher,$tagsFields,$departmentFields';

      initialUrl += '&$authorValue';
      initialUrl += '&$titleValue';
      initialUrl += '&$isbnIssnValue';
      initialUrl += '&$publisherValue';
      initialUrl += '&$departmenValues';
      initialUrl += '&$tagsValues';
    }

    String url = nextPage ?? initialUrl;

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
