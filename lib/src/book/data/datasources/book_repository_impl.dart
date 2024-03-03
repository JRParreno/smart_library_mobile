import 'package:smart_libary_app/core/config/app_constant.dart';
import 'package:smart_libary_app/core/interceptor/api_interceptor.dart';
import 'package:smart_libary_app/src/book/data/models/book_filter_model.dart';
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
    required BookFilterModel filters,
    String? nextPage,
  }) async {
    String initialUrl = '';
    String fields = '';
    String values = '';
    String departments = '';

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

      if (filters.isAuthor) {
        values += '&$authorValue';
        fields += 'author,';
      }

      if (filters.isDepartment) {
        values += '&$departmenValues';
        fields += '$departmentFields,';

        if (filters.departments.isNotEmpty) {
          final deptIds = filters.departments
              .where((e) => e.isEnable)
              .toList()
              .map((e) => e.department.id.toString())
              .join(',');

          departments = '&departments=$deptIds';
        }
      }

      if (filters.isIssnIsbn) {
        values += '&$isbnIssnValue';
        fields += 'isbn_issn,';
      }

      if (filters.isPublisher) {
        values += '&$publisherValue';
        fields += 'publisher,';
      }

      if (filters.isSubjects) {
        values += '&$tagsValues';
        fields += '$tagsFields,';
      }

      if (filters.isTitle) {
        values += '&$titleValue';
        fields += 'title,';
      }

      initialUrl =
          '${AppConstant.apiUrl}/book-list?search_fields=$fields$values$departments';
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
