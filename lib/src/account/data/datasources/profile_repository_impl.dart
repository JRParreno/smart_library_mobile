import 'dart:io';

import 'package:dio/dio.dart';
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

  @override
  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    const String url = '${AppConstant.apiUrl}/change-password';

    final data = {"old_password": oldPassword, "new_password": newPassword};

    await ApiInterceptor.apiInstance()
        .patch(url, data: data)
        .catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<Profile> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
  }) async {
    const String url = '${AppConstant.apiUrl}/profile';

    final data = {
      "user": {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
      },
      "gender": gender,
    };

    return await ApiInterceptor.apiInstance()
        .patch(url, data: data)
        .then((value) {
      final response = Profile.fromMap(value.data);
      return response;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<String> uploadPhoto(
      {required String pk, required String imagePath}) async {
    String url = '${AppConstant.apiUrl}/upload-photo/$pk';
    DateTime dateToday = DateTime.now();

    final data = FormData.fromMap(
      {
        "profile_photo": await MultipartFile.fromFile(imagePath,
            filename: '$dateToday - ${imagePath.split('/').last}'),
      },
    );

    return await ApiInterceptor.apiInstance()
        .put(
      url,
      data: data,
      options: Options(
        contentType: "multipart/form-data",
      ),
    )
        .then((value) {
      return value.data['profile_photo'];
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
