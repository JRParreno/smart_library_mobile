import 'package:dio/dio.dart';
import 'package:smart_libary_app/core/config/app_constant.dart';
import 'package:smart_libary_app/src/account/domain/repositories/forgot_password_repository.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  @override
  Future<String> forgotPassowrd(String email) async {
    String url = '${AppConstant.apiUrl}/forgot-password';
    final Dio dio = Dio();

    final data = {
      'email_address': email,
    };

    return await dio
        .post(
      url,
      data: data,
    )
        .then((value) {
      return value.data['success'];
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
