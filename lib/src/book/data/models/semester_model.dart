import 'package:equatable/equatable.dart';

class SemesterModel extends Equatable {
  final String semester;
  final String value;
  final bool isEnable;

  const SemesterModel({
    required this.semester,
    required this.value,
    this.isEnable = true,
  });

  @override
  List<Object?> get props => [
        semester,
        value,
        isEnable,
      ];

  SemesterModel copyWith({
    String? semester,
    String? value,
    bool? isEnable,
  }) {
    return SemesterModel(
      semester: semester ?? this.semester,
      value: value ?? this.value,
      isEnable: isEnable ?? this.isEnable,
    );
  }
}
