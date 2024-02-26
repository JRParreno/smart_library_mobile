import 'package:equatable/equatable.dart';

class SignupModel extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String password;
  final String confirmPassword;

  const SignupModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        gender,
        password,
        confirmPassword,
      ];
}
