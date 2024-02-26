part of 'home_book_bloc.dart';

abstract class HomeBookEvent extends Equatable {
  const HomeBookEvent();

  @override
  List<Object> get props => [];
}

class OnGetHomeBookEvent extends HomeBookEvent {}

class OnPaginateHoomBookEvent extends HomeBookEvent {}
