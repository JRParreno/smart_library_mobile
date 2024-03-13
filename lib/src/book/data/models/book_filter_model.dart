import 'package:equatable/equatable.dart';

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
  final bool isDepartment;
  final List<DepartmentFilterModel> departments;
  final double rate;

  const BookFilterModel({
    required this.departments,
    this.isAuthor = true,
    this.isTitle = true,
    this.isPublisher = true,
    this.isIssnIsbn = true,
    this.isSubjects = true,
    this.isDepartment = true,
    this.rate = 5,
  });

  factory BookFilterModel.empty() {
    return const BookFilterModel(departments: []);
  }

  BookFilterModel copyWith({
    bool? isAuthor,
    bool? isTitle,
    bool? isPublisher,
    bool? isIssnIsbn,
    bool? isSubjects,
    bool? isDepartment,
    List<DepartmentFilterModel>? departments,
    double? rate,
  }) {
    return BookFilterModel(
      isAuthor: isAuthor ?? this.isAuthor,
      isTitle: isTitle ?? this.isTitle,
      isPublisher: isPublisher ?? this.isPublisher,
      isIssnIsbn: isIssnIsbn ?? this.isIssnIsbn,
      isSubjects: isSubjects ?? this.isSubjects,
      isDepartment: isDepartment ?? this.isDepartment,
      departments: departments ?? this.departments,
      rate: rate ?? this.rate,
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
      isDepartment,
      departments,
      rate,
    ];
  }
}
