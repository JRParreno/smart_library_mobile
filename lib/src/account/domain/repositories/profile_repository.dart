import 'package:smart_libary_app/src/account/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getUserProfile();
  Future<void> setPushToken(String token);
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<Profile> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
  });
  Future<String> uploadPhoto({
    required String pk,
    required String imagePath,
  });
}
