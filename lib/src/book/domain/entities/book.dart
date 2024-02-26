import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:smart_libary_app/src/department/domain/entities/department.dart';

class Book extends Equatable {
  final int id;
  final Department department;
  final String author;
  final String title;
  final int year;
  final double rate;
  final String description;
  final String? coverPhoto;
  final List<String> bookPhotos;
  final int iso;
  final int numberCopies;
  final int viewCount;

  const Book({
    required this.id,
    required this.department,
    required this.author,
    required this.title,
    required this.year,
    required this.rate,
    required this.description,
    required this.iso,
    required this.numberCopies,
    required this.viewCount,
    this.coverPhoto,
    this.bookPhotos = const [],
  });

  @override
  List<Object?> get props {
    return [
      id,
      department,
      author,
      title,
      year,
      rate,
      description,
      coverPhoto,
      bookPhotos,
      iso,
      viewCount,
      numberCopies
    ];
  }

  factory Book.empty() {
    return const Book(
      id: -1,
      department: Department(id: -1, name: '', acronym: ''),
      author: 'Stephen Hawking',
      title: 'Calculus',
      year: 2008,
      rate: 3.5,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      coverPhoto:
          'https://media.springernature.com/full/springer-static/cover-hires/book/978-3-319-57354-0',
      iso: 20917732,
      bookPhotos: [
        'https://media.springernature.com/full/springer-static/cover-hires/book/978-3-319-57354-0',
        'https://media.springernature.com/full/springer-static/cover-hires/book/978-3-319-57354-0',
        'https://bookPhotos.inc.com/uploaded_files/image/1920x1080/getty_655998316_2000149920009280219_363765.jpg',
        'https://media.springernature.com/full/springer-static/cover-hires/book/978-3-319-57354-0',
        'https://bookPhotos.inc.com/uploaded_files/image/1920x1080/getty_655998316_2000149920009280219_363765.jpg',
      ],
      numberCopies: -1,
      viewCount: -1,
    );
  }

  Book copyWith({
    int? id,
    Department? department,
    String? author,
    String? title,
    int? year,
    String? course,
    double? rate,
    String? description,
    String? coverPhoto,
    List<String>? bookPhotos,
    int? iso,
    int? numberCopies,
    int? viewCount,
  }) {
    return Book(
      id: id ?? this.id,
      department: department ?? this.department,
      author: author ?? this.author,
      title: title ?? this.title,
      year: year ?? this.year,
      rate: rate ?? this.rate,
      description: description ?? this.description,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      bookPhotos: bookPhotos ?? this.bookPhotos,
      iso: iso ?? this.iso,
      viewCount: viewCount ?? this.viewCount,
      numberCopies: numberCopies ?? this.numberCopies,
    );
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['pk']?.toInt() ?? 0,
      department: Department.fromMap(map['department']),
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      year: map['year']?.toInt() ?? 0,
      rate: map['rate']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      coverPhoto: map['cover_photo'],
      bookPhotos: List<String>.from(map['book_photos']),
      iso: map['iso']?.toInt() ?? 0,
      viewCount: map['viewCount']?.toInt() ?? 0,
      numberCopies: map['numberCopies']?.toInt() ?? 0,
    );
  }

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}
