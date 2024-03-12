part of 'book_detail_bloc.dart';

abstract class BookDetailEvent extends Equatable {
  const BookDetailEvent();

  @override
  List<Object> get props => [];
}

class OnSetBookDetailEvent extends BookDetailEvent {
  final Book book;

  const OnSetBookDetailEvent(this.book);

  @override
  List<Object> get props => [book];
}

class OnRateBookEvent extends BookDetailEvent {
  final double rate;

  const OnRateBookEvent(this.rate);

  @override
  List<Object> get props => [rate];
}

class OnSaveBookEvent extends BookDetailEvent {}
