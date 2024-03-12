part of 'book_rate_cubit.dart';

class BookRateState extends Equatable {
  final double initialRate;
  final double modifiedRate;

  const BookRateState({
    required this.initialRate,
    required this.modifiedRate,
  });

  @override
  List<Object> get props => [
        initialRate,
        modifiedRate,
      ];

  BookRateState copyWith({
    double? initialRate,
    double? modifiedRate,
  }) {
    return BookRateState(
      initialRate: initialRate ?? this.initialRate,
      modifiedRate: modifiedRate ?? this.modifiedRate,
    );
  }
}
