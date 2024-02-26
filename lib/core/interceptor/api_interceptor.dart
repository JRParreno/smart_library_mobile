import 'package:dio/dio.dart';
import 'package:smart_libary_app/core/interceptor/dio_interceptor.dart';

class ApiInterceptor {
  static Dio apiInstance() {
    Dio dio = Dio();
    dio.interceptors.add(DioInterceptor());
    return dio;
  }
}
