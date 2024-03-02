part of 'search_book_bloc.dart';

abstract class SearchBookState extends Equatable {
  const SearchBookState();

  @override
  List<Object> get props => [];
}

class SearchBookInitial extends SearchBookState {}

class SearchBookLoading extends SearchBookState {}

class SearchBookLoaded extends SearchBookState {
  final BookModel bookModel;
  final bool isPaginate;

  const SearchBookLoaded({
    required this.bookModel,
    this.isPaginate = false,
  });

  @override
  List<Object> get props => [
        bookModel,
        isPaginate,
      ];

  SearchBookLoaded copyWith({
    BookModel? bookModel,
    bool? isPaginate,
  }) {
    return SearchBookLoaded(
      bookModel: bookModel ?? this.bookModel,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }
}

class SearchBookError extends SearchBookState {
  final String errorMessage;

  const SearchBookError(this.errorMessage);

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
