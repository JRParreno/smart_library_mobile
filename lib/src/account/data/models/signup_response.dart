import 'package:equatable/equatable.dart';

class SignupResponse extends Equatable {
  final dynamic data;
  final String status;

  const SignupResponse({
    required this.data,
    required this.status,
  });

  @override
  List<Object?> get props => [
        data,
        status,
      ];
}
