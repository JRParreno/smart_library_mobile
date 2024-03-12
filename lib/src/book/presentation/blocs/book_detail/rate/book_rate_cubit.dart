import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_rate_state.dart';

class BookRateCubit extends Cubit<BookRateState> {
  BookRateCubit() : super(const BookRateState(initialRate: 0, modifiedRate: 0));

  void onSetInitialRate(double rate) {
    final state = this.state;
    emit(state.copyWith(modifiedRate: rate, initialRate: rate));
  }

  void onChangedRate(double rate) {
    final state = this.state;
    emit(state.copyWith(modifiedRate: rate));
  }

  void onSubmitRate(double rate) {
    final state = this.state;
    emit(
      state.copyWith(
        modifiedRate: rate,
        initialRate: rate,
      ),
    );
  }
}
