part of 'home_book_bloc.dart';

abstract class HomeBookEvent extends Equatable {
  const HomeBookEvent();

  @override
  List<Object> get props => [];
}

class OnGetHomeBookEvent extends HomeBookEvent {}

class OnPaginateHoomBookEvent extends HomeBookEvent {}

class OnFilterCategoriesBookEvent extends HomeBookEvent {
  final BookFilterModel filters;

  const OnFilterCategoriesBookEvent(this.filters);

  @override
  List<Object> get props => [
        filters,
      ];
}
