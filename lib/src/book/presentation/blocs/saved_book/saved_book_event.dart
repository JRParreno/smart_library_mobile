part of 'saved_book_bloc.dart';

abstract class SavedBookEvent extends Equatable {
  const SavedBookEvent();

  @override
  List<Object> get props => [];
}

class OnGetSavedBookEvent extends SavedBookEvent {}

class OnPaginateSavedBookEvent extends SavedBookEvent {}
