import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_libary_app/src/book/data/models/book_filter_model.dart';
import 'package:smart_libary_app/src/book/data/models/book_model.dart';
import 'package:smart_libary_app/src/book/domain/repositories/book_repository.dart';

part 'home_book_event.dart';
part 'home_book_state.dart';

class HomeBookBloc extends Bloc<HomeBookEvent, HomeBookState> {
  final BookRepository repository;

  HomeBookBloc(this.repository) : super(HomeBookInitial()) {
    on<OnGetHomeBookEvent>(onGetHomeBookEvent);
    on<OnPaginateHoomBookEvent>(onPaginateHoomBookEvent);
    on<OnFilterCategoriesBookEvent>(onFilterCategoriesBookEvent);
  }

  Future<void> onGetHomeBookEvent(
      OnGetHomeBookEvent event, Emitter<HomeBookState> emit) async {
    emit(HomeBookLoading());

    try {
      final response = await repository.getBooks();

      emit(
        HomeBookLoaded(
          bookModel: response,
        ),
      );
    } catch (e) {
      emit(HomeBookError(e.toString()));
    }
  }

  Future<void> onPaginateHoomBookEvent(
      OnPaginateHoomBookEvent event, Emitter<HomeBookState> emit) async {
    final state = this.state;

    if (state is HomeBookLoaded &&
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
        emit(HomeBookError(e.toString()));
      }
    }
  }

  Future<void> onFilterCategoriesBookEvent(
      OnFilterCategoriesBookEvent event, Emitter<HomeBookState> emit) async {
    emit(HomeBookLoading());

    try {
      final response = await repository.getSearchBooks(
        search: '',
        filters: event.filters,
      );

      emit(
        HomeBookLoaded(
          bookModel: response,
        ),
      );
    } catch (e) {
      emit(HomeBookError(e.toString()));
    }
  }
}
