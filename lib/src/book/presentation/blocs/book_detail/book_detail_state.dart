part of 'book_detail_bloc.dart';

abstract class BookDetailState extends Equatable {
  const BookDetailState();

  @override
  List<Object> get props => [];
}

class BookDetailInitial extends BookDetailState {}

class BookDetailLoaded extends BookDetailState {
  final Book book;
  final bool isLoading;

  const BookDetailLoaded({
    required this.book,
    this.isLoading = false,
  });

  BookDetailLoaded copyWith({
    Book? book,
    bool? isLoading,
  }) {
    return BookDetailLoaded(
      book: book ?? this.book,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        book,
        isLoading,
      ];
}

class BookDetailError extends BookDetailState {
  final String errorMessage;

  const BookDetailError(this.errorMessage);

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
