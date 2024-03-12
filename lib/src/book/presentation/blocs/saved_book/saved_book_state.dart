part of 'saved_book_bloc.dart';

abstract class SavedBookState extends Equatable {
  const SavedBookState();

  @override
  List<Object> get props => [];
}

class SavedBookInitial extends SavedBookState {}

class SavedBookLoading extends SavedBookState {}

class SavedBookLoaded extends SavedBookState {
  final BookModel bookModel;
  final bool isPaginate;

  const SavedBookLoaded({
    required this.bookModel,
    this.isPaginate = false,
  });

  @override
  List<Object> get props => [
        bookModel,
        isPaginate,
      ];

  SavedBookLoaded copyWith({
    BookModel? bookModel,
    bool? isPaginate,
  }) {
    return SavedBookLoaded(
      bookModel: bookModel ?? this.bookModel,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }
}

class SavedBookError extends SavedBookState {
  final String errorMessage;

  const SavedBookError(this.errorMessage);

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
