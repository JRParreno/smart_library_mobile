import 'package:smart_libary_app/src/account/data/models/signup_response.dart';

abstract class LoginRepository {
  Future<SignupResponse> login({
    required String email,
    required String password,
  });
}
