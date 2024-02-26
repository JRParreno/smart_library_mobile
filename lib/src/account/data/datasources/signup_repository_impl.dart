import 'package:dio/dio.dart';
import 'package:smart_libary_app/core/config/app_constant.dart';
import 'package:smart_libary_app/src/account/data/models/signup_model.dart';
import 'package:smart_libary_app/src/account/data/models/signup_response.dart';
import 'package:smart_libary_app/src/account/domain/repositories/signup_repository.dart';

class SignupRepositoryImpl extends SignupRepository {
  final Dio dio = Dio();

  @override
  Future<SignupResponse> signup(SignupModel signupModel) async {
    String url = '${AppConstant.apiUrl}/register';

    final data = {
      "email": signupModel.email,
      "first_name": signupModel.firstName,
      "last_name": signupModel.lastName,
      "password": signupModel.password,
      "confirm_password": signupModel.confirmPassword,
      "gender": signupModel.gender,
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
