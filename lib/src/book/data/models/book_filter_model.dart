import 'package:equatable/equatable.dart';

import 'package:smart_libary_app/src/book/data/models/semester_model.dart';
import 'package:smart_libary_app/src/book/data/models/year_level_model.dart';
import 'package:smart_libary_app/src/department/domain/entities/department.dart';

class DepartmentFilterModel extends Equatable {
  final Department department;
  final bool isEnable;

  const DepartmentFilterModel({
    required this.department,
    this.isEnable = true,
  });

  DepartmentFilterModel copyWith({
    Department? department,
    bool? isEnable,
  }) {
    return DepartmentFilterModel(
      department: department ?? this.department,
      isEnable: isEnable ?? this.isEnable,
    );
  }

  @override
  List<Object> get props => [
        department,
        isEnable,
      ];
}

class BookFilterModel extends Equatable {
  final bool isAuthor;
  final bool isTitle;
  final bool isPublisher;
  final bool isIssnIsbn;
  final bool isSubjects;
  final List<DepartmentFilterModel> departments;
  final double rate;
  final List<YearLevelModel> yearLevels;
  final List<SemesterModel> semesters;

  const BookFilterModel({
    required this.departments,
    required this.yearLevels,
    required this.semesters,
    this.isAuthor = true,
    this.isTitle = true,
    this.isPublisher = true,
    this.isIssnIsbn = true,
    this.isSubjects = true,
    this.rate = 5,
  });

  factory BookFilterModel.empty() {
    const semesters = [
      SemesterModel(semester: 'First Semester', value: 'FIRST_SEM'),
      SemesterModel(semester: 'Second Semester', value: 'SECOND_SEM'),
    ];

    const yearLevels = [
      YearLevelModel(yearLevel: '1st Year', value: 'FIRST_YEAR'),
      YearLevelModel(yearLevel: '2nd Year', value: 'SECOND_YEAR'),
      YearLevelModel(yearLevel: '3rd Year', value: 'THIRD_YEAR'),
      YearLevelModel(yearLevel: '4th Year', value: 'FOURTH_YEAR'),
    ];

    return const BookFilterModel(
      departments: [],
      semesters: semesters,
      yearLevels: yearLevels,
    );
  }

  BookFilterModel copyWith({
    bool? isAuthor,
    bool? isTitle,
    bool? isPublisher,
    bool? isIssnIsbn,
    bool? isSubjects,
    List<DepartmentFilterModel>? departments,
    double? rate,
    List<YearLevelModel>? yearLevels,
    List<SemesterModel>? semesters,
  }) {
    return BookFilterModel(
      isAuthor: isAuthor ?? this.isAuthor,
      isTitle: isTitle ?? this.isTitle,
      isPublisher: isPublisher ?? this.isPublisher,
      isIssnIsbn: isIssnIsbn ?? this.isIssnIsbn,
      isSubjects: isSubjects ?? this.isSubjects,
      departments: departments ?? this.departments,
      rate: rate ?? this.rate,
      yearLevels: yearLevels ?? this.yearLevels,
      semesters: semesters ?? this.semesters,
    );
  }

  @override
  List<Object?> get props {
    return [
      isAuthor,
      isTitle,
      isPublisher,
      isIssnIsbn,
      isSubjects,
      departments,
      rate,
      semesters,
      yearLevels,
    ];
  }
}
