import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:smart_libary_app/src/book/domain/entities/tag.dart';

import 'package:smart_libary_app/src/department/domain/entities/department.dart';

class Book extends Equatable {
  final int id;
  final Department department;
  final String title;
  final String author;
  final int popularity;
  final String coverPhoto;
  final String description;
  final int numberCopies;
  final int viewCount;
  final int year;
  final List<Tag> tags;
  final String isbnIssn;
  final String ddcNumber;
  final String editionStatement;
  final String publisher;
  final String generalInformation;
  final String physicalDescription;
  final String? imprint;
  final String? controlNumber;
  final String? callNumber;
  final String? discipline;
  final List<String> bookPhotos;
  final double rate;
  final double totalRate;
  final bool isRate;
  final int? ratePk;
  final bool isSave;
  final int? savePk;

  const Book({
    required this.id,
    required this.department,
    required this.title,
    required this.author,
    required this.popularity,
    required this.coverPhoto,
    required this.description,
    required this.numberCopies,
    required this.viewCount,
    required this.year,
    required this.tags,
    required this.isbnIssn,
    required this.ddcNumber,
    required this.editionStatement,
    required this.publisher,
    required this.generalInformation,
    required this.physicalDescription,
    required this.bookPhotos,
    this.totalRate = 0,
    this.isRate = false,
    this.isSave = false,
    this.rate = 0,
    this.imprint,
    this.controlNumber,
    this.callNumber,
    this.discipline,
    this.ratePk,
    this.savePk,
  });

  @override
  List<Object?> get props {
    return [
      id,
      department,
      title,
      author,
      popularity,
      coverPhoto,
      description,
      numberCopies,
      viewCount,
      year,
      tags,
      isbnIssn,
      ddcNumber,
      editionStatement,
      publisher,
      generalInformation,
      physicalDescription,
      imprint,
      controlNumber,
      callNumber,
      discipline,
      bookPhotos,
      rate,
      isRate,
      isSave,
      ratePk,
      totalRate,
      savePk,
    ];
  }

  factory Book.empty() {
    return const Book(
      id: -1,
      department: Department(id: -1, name: '', acronym: ''),
      author: 'Stephen Hawking',
      title: 'Calculus',
      year: 2008,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      coverPhoto:
          'https://media.springernature.com/full/springer-static/cover-hires/book/978-3-319-57354-0',
      bookPhotos: [
        'https://media.springernature.com/full/springer-static/cover-hires/book/978-3-319-57354-0',
        'https://media.springernature.com/full/springer-static/cover-hires/book/978-3-319-57354-0',
        'https://bookPhotos.inc.com/uploaded_files/image/1920x1080/getty_655998316_2000149920009280219_363765.jpg',
        'https://media.springernature.com/full/springer-static/cover-hires/book/978-3-319-57354-0',
        'https://bookPhotos.inc.com/uploaded_files/image/1920x1080/getty_655998316_2000149920009280219_363765.jpg',
      ],
      numberCopies: -1,
      viewCount: -1,
      ddcNumber: '123',
      editionStatement: '1st edition',
      generalInformation: 'gen info',
      isbnIssn: '12',
      physicalDescription: 'physical description',
      popularity: 1,
      publisher: 'publisher',
      tags: [],
    );
  }

  Book copyWith({
    int? id,
    Department? department,
    String? title,
    String? author,
    int? popularity,
    String? coverPhoto,
    String? description,
    int? numberCopies,
    int? viewCount,
    int? year,
    List<Tag>? tags,
    String? isbnIssn,
    String? ddcNumber,
    String? editionStatement,
    String? publisher,
    String? generalInformation,
    String? physicalDescription,
    String? imprint,
    String? controlNumber,
    String? callNumber,
    String? discipline,
    List<String>? bookPhotos,
    double? rate,
    bool? isRate,
    bool? isSave,
    int? ratePk,
    double? totalRate,
    int? savePk,
  }) {
    return Book(
      id: id ?? this.id,
      department: department ?? this.department,
      title: title ?? this.title,
      author: author ?? this.author,
      popularity: popularity ?? this.popularity,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      description: description ?? this.description,
      numberCopies: numberCopies ?? this.numberCopies,
      viewCount: viewCount ?? this.viewCount,
      year: year ?? this.year,
      tags: tags ?? this.tags,
      isbnIssn: isbnIssn ?? this.isbnIssn,
      ddcNumber: ddcNumber ?? this.ddcNumber,
      editionStatement: editionStatement ?? this.editionStatement,
      publisher: publisher ?? this.publisher,
      generalInformation: generalInformation ?? this.generalInformation,
      physicalDescription: physicalDescription ?? this.physicalDescription,
      imprint: imprint ?? this.imprint,
      controlNumber: controlNumber ?? this.controlNumber,
      callNumber: callNumber ?? this.callNumber,
      discipline: discipline ?? this.discipline,
      bookPhotos: bookPhotos ?? this.bookPhotos,
      rate: rate ?? this.rate,
      isRate: isRate ?? this.isRate,
      isSave: isSave ?? this.isSave,
      ratePk: ratePk ?? this.ratePk,
      totalRate: totalRate ?? this.totalRate,
      savePk: savePk ?? this.savePk,
    );
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['pk']?.toInt() ?? 0,
      department: Department.fromMap(map['department']),
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      popularity: map['popularity']?.toInt() ?? 0,
      coverPhoto: map['cover_photo'] ?? '',
      description: map['description'] ?? '',
      numberCopies: map['number_copies']?.toInt() ?? 0,
      viewCount: map['view_count']?.toInt() ?? 0,
      year: map['year']?.toInt() ?? 0,
      tags: List<Tag>.from(map['tags']?.map((x) => Tag.fromMap(x))),
      isbnIssn: map['isbn_issn'] ?? '',
      ddcNumber: map['ddc_number'] ?? '',
      editionStatement: map['edition_statement'] ?? '',
      publisher: map['publisher'] ?? '',
      generalInformation: map['general_information'] ?? '',
      physicalDescription: map['physical_description'] ?? '',
      imprint: map['imprint'],
      controlNumber: map['control_number'],
      callNumber: map['call_number'],
      discipline: map['discipline'],
      isRate: map['is_rate'],
      isSave: map['is_save'],
      ratePk: map['rate_pk'],
      savePk: map['save_pk'],
      totalRate: map['total_rate'],
      bookPhotos: List<String>.from(
        map['book_photos'],
      ),
      rate: map['rate']?.toDouble() ?? 0,
    );
  }

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}
