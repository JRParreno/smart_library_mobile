part of 'search_filter_cubit.dart';

abstract class SearchFilterState extends Equatable {
  const SearchFilterState();

  @override
  List<Object> get props => [];
}

class SearchFilterInitial extends SearchFilterState {
  final BookFilterModel bookFilterModel;

  const SearchFilterInitial(this.bookFilterModel);

  @override
  List<Object> get props => [
        bookFilterModel,
      ];
}
