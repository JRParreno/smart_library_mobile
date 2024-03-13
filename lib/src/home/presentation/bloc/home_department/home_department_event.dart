part of 'home_department_bloc.dart';

abstract class HomeDepartmentEvent extends Equatable {
  const HomeDepartmentEvent();

  @override
  List<Object> get props => [];
}

class OnGetHomeDepartmentEvent extends HomeDepartmentEvent {}

class OnTapHomeDepartmentEvent extends HomeDepartmentEvent {
  final int index;

  const OnTapHomeDepartmentEvent(this.index);

  @override
  List<Object> get props => [index];
}
