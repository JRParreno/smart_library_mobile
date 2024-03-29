import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_libary_app/src/department/data/models/department_model.dart';
import 'package:smart_libary_app/src/department/domain/repository/department_repository.dart';

part 'home_department_event.dart';
part 'home_department_state.dart';

class HomeDepartmentBloc
    extends Bloc<HomeDepartmentEvent, HomeDepartmentState> {
  final DepartmentRepository repository;

  HomeDepartmentBloc(
    this.repository,
  ) : super(HomeDepartmentInitial()) {
    on<OnGetHomeDepartmentEvent>(onGetHomeDepartmentEvent);
    on<OnTapHomeDepartmentEvent>(onTapHomeDepartmentEvent);
  }

  Future<void> onGetHomeDepartmentEvent(
      OnGetHomeDepartmentEvent event, Emitter<HomeDepartmentState> emit) async {
    emit(HomeDepartmentLoading());

    try {
      final response = await repository.getDepartments();

      emit(HomeDepartmentLoaded(departmentModel: response));
    } catch (e) {
      emit(HomeDepartmentError(e.toString()));
    }
  }

  void onTapHomeDepartmentEvent(
      OnTapHomeDepartmentEvent event, Emitter<HomeDepartmentState> emit) async {
    final state = this.state;

    if (state is HomeDepartmentLoaded) {
      emit(state.copyWith(index: event.index));
    }
  }
}
