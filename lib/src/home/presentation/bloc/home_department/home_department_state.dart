part of 'home_department_bloc.dart';

abstract class HomeDepartmentState extends Equatable {
  const HomeDepartmentState();

  @override
  List<Object> get props => [];
}

class HomeDepartmentInitial extends HomeDepartmentState {}

class HomeDepartmentLoading extends HomeDepartmentState {}

class HomeDepartmentLoaded extends HomeDepartmentState {
  final DepartmentModel departmentModel;

  const HomeDepartmentLoaded(
    this.departmentModel,
  );

  @override
  List<Object> get props => [departmentModel];

  HomeDepartmentLoaded copyWith({
    DepartmentModel? departmentModel,
  }) {
    return HomeDepartmentLoaded(
      departmentModel ?? this.departmentModel,
    );
  }
}

class HomeDepartmentError extends HomeDepartmentState {
  final String errorMessage;

  const HomeDepartmentError(this.errorMessage);

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
