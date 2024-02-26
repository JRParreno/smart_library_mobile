import 'dart:convert';

import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final int id;
  final String name;
  final String acronym;

  const Department({
    required this.id,
    required this.name,
    required this.acronym,
  });

  @override
  List<Object> get props => [id, name, acronym];

  Department copyWith({
    int? id,
    String? name,
    String? acronym,
  }) {
    return Department(
      id: id ?? this.id,
      name: name ?? this.name,
      acronym: acronym ?? this.acronym,
    );
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['pk']?.toInt() ?? 0,
      name: map['name'] ?? '',
      acronym: map['acronym'] ?? '',
    );
  }

  factory Department.fromJson(String source) =>
      Department.fromMap(json.decode(source));
}
