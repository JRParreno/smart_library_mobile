import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_libary_app/src/book/data/models/book_model.dart';
import 'package:smart_libary_app/src/book/domain/repositories/book_repository.dart';

part 'saved_book_event.dart';
part 'saved_book_state.dart';

class SavedBookBloc extends Bloc<SavedBookEvent, SavedBookState> {
  final BookRepository repository;

  SavedBookBloc(this.repository) : super(SavedBookInitial()) {
    on<OnGetSavedBookEvent>(onGetSavedBookEvent);
    on<OnPaginateSavedBookEvent>(onPaginateSavedBookEvent);
  }

  Future<void> onGetSavedBookEvent(
      OnGetSavedBookEvent event, Emitter<SavedBookState> emit) async {
    emit(SavedBookLoading());

    try {
      final response = await repository.getSaveBook();

      emit(
        SavedBookLoaded(
          bookModel: response,
        ),
      );
    } catch (e) {
      emit(SavedBookError(e.toString()));
    }
  }

  Future<void> onPaginateSavedBookEvent(
      OnPaginateSavedBookEvent event, Emitter<SavedBookState> emit) async {
    final state = this.state;

    if (state is SavedBookLoaded &&
        state.bookModel.nextPage != null &&
        !state.isPaginate) {
      emit(state.copyWith(isPaginate: true));

      try {
        final response =
            await repository.getBooks(nextPage: state.bookModel.nextPage);

        emit(
          state.copyWith(
            bookModel: response.copyWith(
              books: [...state.bookModel.books, ...response.books],
            ),
            isPaginate: false,
          ),
        );
      } catch (e) {
        emit(SavedBookError(e.toString()));
      }
    }
  }
}
