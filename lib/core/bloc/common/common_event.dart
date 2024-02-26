import 'package:equatable/equatable.dart';
import 'package:smart_libary_app/core/bloc/profile/profile_bloc.dart';

abstract class CommonEvent extends Equatable implements ProfileEvent {
  const CommonEvent();

  @override
  List<Object> get props => [];
}

// initial state for all blocs
class InitialEvent extends CommonEvent {
  const InitialEvent();
}

class NoInternetConnectionEvent extends CommonEvent {
  const NoInternetConnectionEvent();
}
