import 'package:smart_libary_app/src/account/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getUserProfile();
  Future<void> setPushToken(String token);
}
