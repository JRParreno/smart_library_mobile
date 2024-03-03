part of 'search_book_bloc.dart';

abstract class SearchBookEvent extends Equatable {
  const SearchBookEvent();

  @override
  List<Object> get props => [];
}

class OnGetSearchBookEvent extends SearchBookEvent {
  final String search;
  final BookFilterModel filters;

  const OnGetSearchBookEvent({
    required this.search,
    required this.filters,
  });

  @override
  List<Object> get props => [
        search,
        filters,
      ];
}

class OnPaginateSearchBookEvent extends SearchBookEvent {}
