import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_libary_app/src/book/data/models/book_filter_model.dart';
import 'package:smart_libary_app/src/department/domain/repository/department_repository.dart';

part 'search_filter_state.dart';

class SearchFilterCubit extends Cubit<BookFilterModel> {
  final DepartmentRepository departmentRepository;

  SearchFilterCubit(this.departmentRepository) : super(BookFilterModel.empty());

  Future<void> onGetCategories() async {
    final response = await departmentRepository.getDepartments();

    final filterDepartments = response.departments.map((e) {
      final temp = state.departments
          .firstWhereOrNull((element) => element.department.id == e.id);

      if (temp == null) {
        return DepartmentFilterModel(department: e);
      }

      return temp;
    }).toList();

    emit(state.copyWith(departments: filterDepartments));
  }

  void onApplyFilter(BookFilterModel filters) {
    emit(filters);
  }
}
