import 'package:dio/dio.dart';
import 'package:smart_libary_app/core/config/app_constant.dart';
import 'package:smart_libary_app/src/account/data/models/signup_response.dart';
import 'package:smart_libary_app/src/account/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final Dio dio = Dio();

  @override
  Future<SignupResponse> login(
      {required String email, required String password}) async {
    String url = '${AppConstant.serverUrl}/o/token/';

    Map<String, dynamic> data = {
      'username': email,
      'password': password,
      'grant_type': 'password',
      'client_id': AppConstant.clientId,
      'client_secret': AppConstant.clientSecret
    };

    return await dio.post(url, data: data).then((value) {
      return SignupResponse(
          data: value.data, status: value.statusCode?.toString() ?? '');
    }).onError((Response<dynamic> error, stackTrace) {
      throw {
        'status': error.statusCode.toString(),
        'data': error.data,
      };
    }).catchError((onError) {
      final error = onError as DioException;

      if (error.response != null && error.response!.data != null) {
        throw {
          'status': error.response?.statusCode ?? '400',
          'data': error.response!.data,
        };
      }

      throw error;
    });
  }
}
