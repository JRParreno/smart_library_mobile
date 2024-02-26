import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:smart_libary_app/src/book/domain/entities/book.dart';

class BookModel extends Equatable {
  final List<Book> books;
  final String? nextPage;
  final int totalCount;

  const BookModel({
    required this.books,
    required this.nextPage,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [
        books,
        nextPage,
        totalCount,
      ];

  BookModel copyWith({
    List<Book>? books,
    String? nextPage,
    int? totalCount,
  }) {
    return BookModel(
      books: books ?? this.books,
      nextPage: nextPage ?? this.nextPage,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      books: List<Book>.from(map['books']?.map((x) => Book.fromMap(x))),
      nextPage: map['next'],
      totalCount: map['totalCount']?.toInt() ?? 0,
    );
  }

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source));
}
