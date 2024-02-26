import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:smart_libary_app/src/department/domain/entities/department.dart';

class DepartmentModel extends Equatable {
  final List<Department> departments;
  final int pageNumber;
  final int totalCount;

  const DepartmentModel({
    required this.departments,
    required this.pageNumber,
    required this.totalCount,
  });

  @override
  List<Object> get props => [departments, pageNumber, totalCount];

  DepartmentModel copyWith({
    List<Department>? departments,
    int? pageNumber,
    int? totalCount,
  }) {
    return DepartmentModel(
      departments: departments ?? this.departments,
      pageNumber: pageNumber ?? this.pageNumber,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  factory DepartmentModel.fromMap(Map<String, dynamic> map) {
    return DepartmentModel(
      departments: List<Department>.from(
          map['departments']?.map((x) => Department.fromMap(x))),
      pageNumber: map['pageNumber']?.toInt() ?? 0,
      totalCount: map['totalCount']?.toInt() ?? 0,
    );
  }

  factory DepartmentModel.fromJson(String source) =>
      DepartmentModel.fromMap(json.decode(source));
}
