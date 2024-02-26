import 'package:smart_libary_app/src/account/data/models/signup_model.dart';
import 'package:smart_libary_app/src/account/data/models/signup_response.dart';

abstract class SignupRepository {
  Future<SignupResponse> signup(SignupModel signupModel);
}
