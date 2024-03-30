import 'package:equatable/equatable.dart';

class YearLevelModel extends Equatable {
  final String yearLevel;
  final String value;
  final bool isEnable;

  const YearLevelModel({
    required this.yearLevel,
    required this.value,
    this.isEnable = true,
  });

  @override
  List<Object?> get props => [
        yearLevel,
        value,
        isEnable,
      ];

  YearLevelModel copyWith({
    String? yearLevel,
    String? value,
    bool? isEnable,
  }) {
    return YearLevelModel(
      yearLevel: yearLevel ?? this.yearLevel,
      value: value ?? this.value,
      isEnable: isEnable ?? this.isEnable,
    );
  }
}
