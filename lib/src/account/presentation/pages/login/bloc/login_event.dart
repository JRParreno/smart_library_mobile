part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnSubmitLoginEvent extends LoginEvent {
  final String emailAddress;
  final String password;

  const OnSubmitLoginEvent({
    required this.emailAddress,
    required this.password,
  });

  @override
  List<Object> get props => [
        emailAddress,
        password,
      ];
}
