part of 'search_book_bloc.dart';

abstract class SearchBookEvent extends Equatable {
  const SearchBookEvent();

  @override
  List<Object> get props => [];
}

class OnGetSearchBookEvent extends SearchBookEvent {
  final String search;

  const OnGetSearchBookEvent(this.search);

  @override
  List<Object> get props => [search];
}

class OnPaginateSearchBookEvent extends SearchBookEvent {}
