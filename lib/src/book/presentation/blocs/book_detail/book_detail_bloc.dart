import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_libary_app/src/book/domain/entities/book.dart';
import 'package:smart_libary_app/src/book/domain/repositories/book_repository.dart';

part 'book_detail_event.dart';
part 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final BookRepository repository;

  BookDetailBloc(this.repository) : super(BookDetailInitial()) {
    on<OnSetBookDetailEvent>(onSetBookDetailEvent);
    on<OnRateBookEvent>(onRateBookEvent);
    on<OnSaveBookEvent>(onSaveBookEvent);
  }

  Future<void> onSetBookDetailEvent(
      OnSetBookDetailEvent event, Emitter<BookDetailState> emit) async {
    final book = event.book;

    emit(BookDetailLoaded(book: book, isLoading: true));

    try {
      final state = this.state;

      if (state is BookDetailLoaded) {
        final response = await repository.getDetailBook(book.id);

        emit(BookDetailLoaded(book: response, isLoading: true));
        await repository.viewCountEvent(book.id);
        emit(BookDetailLoaded(book: response, isLoading: false));
      }
    } catch (e) {
      emit(const BookDetailError('Something went wrong'));
    }
  }

  Future<void> onRateBookEvent(
      OnRateBookEvent event, Emitter<BookDetailState> emit) async {
    final state = this.state;

    try {
      if (state is BookDetailLoaded) {
        final ratePk = state.book.ratePk;
        final rate = event.rate;
        emit(state.copyWith(isLoading: true));

        if (ratePk != null) {
          // Update current rate
          await repository.updateRateBook(ratePk: ratePk, rate: rate);
          emit(state.copyWith(book: state.book.copyWith(rate: rate)));
        } else {
          // Add rate
          await repository.addRateBook(bookPk: state.book.id, rate: rate);
        }

        final response = await repository.getDetailBook(state.book.id);
        emit(BookDetailLoaded(book: response, isLoading: false));
      }
    } catch (e) {
      emit(const BookDetailError('Something went wrong please try again'));
    }
  }

  Future<void> onSaveBookEvent(
      OnSaveBookEvent event, Emitter<BookDetailState> emit) async {
    final state = this.state;

    if (state is BookDetailLoaded) {
      emit(state.copyWith(isLoading: true));
      final book = state.book;

      try {
        if (book.isSave && book.savePk != null) {
          // DELETE the book
          await repository.deleteSaveBook(book.savePk!);
        } else {
          await repository.saveBook(book.id);
        }

        final response = await repository.getDetailBook(book.id);

        emit(
          state.copyWith(
            isLoading: false,
            book: response,
          ),
        );
      } catch (e) {
        emit(const BookDetailError('Something went wrong'));
      }
    }
  }
}
