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
    String rate = '';
    String semesters = '';
    String yearLevels = '';

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

      if (filters.departments.where((element) => element.isEnable).isNotEmpty) {
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

      if (filters.semesters.where((element) => element.isEnable).isNotEmpty) {
        if (filters.semesters.isNotEmpty) {
          final semValues = filters.semesters
              .where((e) => e.isEnable)
              .toList()
              .map((e) => e.value)
              .join(',');

          semesters = '&semesters=$semValues';
        }
      }

      if (filters.yearLevels.where((element) => element.isEnable).isNotEmpty) {
        if (filters.yearLevels.isNotEmpty) {
          final yearValues = filters.yearLevels
              .where((e) => e.isEnable)
              .toList()
              .map((e) => e.value)
              .join(',');

          yearLevels = '&year_levels=$yearValues';
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

      if (filters.rate > -1) {
        rate = '&rate=${filters.rate.toString()}';
      }

      initialUrl =
          '${AppConstant.apiUrl}/book-list?search_fields=$fields$values$departments$rate$semesters$yearLevels';
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

  @override
  Future<void> rateBook({required int rate, required int bookPk}) async {
    String url = '${AppConstant.apiUrl}/book-rate/$rate';

    final data = {
      "rate": rate,
      "book": bookPk,
    };
    return await ApiInterceptor.apiInstance()
        .patch(url, data: data)
        .then((value) => null)
        .catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<void> saveBook(int bookPk) async {
    String url = '${AppConstant.apiUrl}/book-saved-create';

    final data = {
      "book": bookPk,
    };

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) => null)
        .catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<void> deleteSaveBook(int savePk) async {
    String url = '${AppConstant.apiUrl}/book-saved-delete/$savePk';

    return await ApiInterceptor.apiInstance()
        .delete(
          url,
        )
        .then((value) => null)
        .catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<void> viewCountEvent(int bookPk) async {
    String url = '${AppConstant.apiUrl}/book-events-view-count';

    final data = {
      "book": bookPk,
    };

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) => null)
        .catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<Book> getDetailBook(int bookPk) async {
    String url = '${AppConstant.apiUrl}/book-detail/$bookPk';

    return await ApiInterceptor.apiInstance()
        .get(
      url,
    )
        .then((value) {
      return Book.fromMap(value.data);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<BookModel> getSaveBook() async {
    String url = '${AppConstant.apiUrl}/book-saved-list';

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
  Future<void> addRateBook({required int bookPk, required double rate}) async {
    String url = '${AppConstant.apiUrl}/book-rate/';

    final data = {
      "book": bookPk,
      "rate": rate,
    };

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) => null)
        .catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<void> updateRateBook(
      {required int ratePk, required double rate}) async {
    String url = '${AppConstant.apiUrl}/book-rate/$ratePk/';

    final data = {
      "rate": rate,
    };

    return await ApiInterceptor.apiInstance()
        .patch(url, data: data)
        .then((value) => null)
        .catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
