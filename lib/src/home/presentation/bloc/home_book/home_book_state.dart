part of 'home_book_bloc.dart';

abstract class HomeBookState extends Equatable {
  const HomeBookState();

  @override
  List<Object> get props => [];
}

class HomeBookInitial extends HomeBookState {}

class HomeBookLoading extends HomeBookState {}

class HomeBookLoaded extends HomeBookState {
  final BookModel bookModel;
  final bool isPaginate;

  const HomeBookLoaded({
    required this.bookModel,
    this.isPaginate = false,
  });

  @override
  List<Object> get props => [
        bookModel,
        isPaginate,
      ];

  HomeBookLoaded copyWith({
    BookModel? bookModel,
    bool? isPaginate,
  }) {
    return HomeBookLoaded(
      bookModel: bookModel ?? this.bookModel,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }
}

class HomeBookError extends HomeBookState {
  final String errorMessage;

  const HomeBookError(this.errorMessage);

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
