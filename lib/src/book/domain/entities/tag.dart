import 'dart:convert';

import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final int id;
  final String name;
  final String acronym;

  const Tag({
    required this.id,
    required this.name,
    required this.acronym,
  });

  @override
  List<Object> get props => [id, name, acronym];

  Tag copyWith({
    int? id,
    String? name,
    String? acronym,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      acronym: acronym ?? this.acronym,
    );
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      acronym: map['acronym'] ?? '',
    );
  }

  factory Tag.fromJson(String source) => Tag.fromMap(json.decode(source));

  @override
  String toString() => 'Tag(id: $id, name: $name, acronym: $acronym)';
}
