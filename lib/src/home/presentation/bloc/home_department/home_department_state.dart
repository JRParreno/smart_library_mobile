part of 'home_department_bloc.dart';

abstract class HomeDepartmentState extends Equatable {
  const HomeDepartmentState();

  @override
  List<Object?> get props => [];
}

class HomeDepartmentInitial extends HomeDepartmentState {}

class HomeDepartmentLoading extends HomeDepartmentState {}

class HomeDepartmentLoaded extends HomeDepartmentState {
  final DepartmentModel departmentModel;
  final int? index;

  const HomeDepartmentLoaded({required this.departmentModel, this.index});

  HomeDepartmentLoaded copyWith({
    DepartmentModel? departmentModel,
    int? index,
  }) {
    return HomeDepartmentLoaded(
      departmentModel: departmentModel ?? this.departmentModel,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [
        departmentModel,
        index,
      ];
}

class HomeDepartmentError extends HomeDepartmentState {
  final String errorMessage;

  const HomeDepartmentError(this.errorMessage);

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
