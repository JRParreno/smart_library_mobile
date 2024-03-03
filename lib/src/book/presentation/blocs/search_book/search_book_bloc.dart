import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_libary_app/src/book/data/models/book_filter_model.dart';
import 'package:smart_libary_app/src/book/data/models/book_model.dart';
import 'package:smart_libary_app/src/book/domain/repositories/book_repository.dart';

part 'search_book_event.dart';
part 'search_book_state.dart';

class SearchBookBloc extends Bloc<SearchBookEvent, SearchBookState> {
  final BookRepository repository;

  SearchBookBloc(this.repository) : super(SearchBookInitial()) {
    on<OnGetSearchBookEvent>(onGetSearchBookEvent);
    on<OnPaginateSearchBookEvent>(onPaginateSearchBookEvent);
  }

  Future<void> onGetSearchBookEvent(
      OnGetSearchBookEvent event, Emitter<SearchBookState> emit) async {
    emit(SearchBookLoading());

    try {
      final response = await repository.getSearchBooks(
        search: event.search,
        filters: event.filters,
      );

      emit(
        SearchBookLoaded(
          bookModel: response,
        ),
      );
    } catch (e) {
      emit(SearchBookError(e.toString()));
    }
  }

  Future<void> onPaginateSearchBookEvent(
      OnPaginateSearchBookEvent event, Emitter<SearchBookState> emit) async {
    final state = this.state;

    if (state is SearchBookLoaded &&
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
        emit(SearchBookError(e.toString()));
      }
    }
  }
}
