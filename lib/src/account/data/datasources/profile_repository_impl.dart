import 'dart:io';

import 'package:smart_libary_app/core/config/app_constant.dart';
import 'package:smart_libary_app/core/interceptor/api_interceptor.dart';
import 'package:smart_libary_app/src/account/domain/entities/profile.dart';
import 'package:smart_libary_app/src/account/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<Profile> getUserProfile() async {
    const String url = '${AppConstant.apiUrl}/profile';
    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final response = Profile.fromMap(value.data);
      return response;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<void> setPushToken(String token) async {
    const String url = '${AppConstant.serverUrl}/devices/';

    final data = {
      "registration_id": token,
      "type": Platform.isAndroid ? "android" : "ios"
    };

    await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .onError((error, stackTrace) {
      throw error!;
    }).catchError((onError) {
      throw onError;
    });
  }
}
