part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class SetProfileEvent extends ProfileEvent {}

class SetProfilePicture extends ProfileEvent {
  final String profilePhoto;

  const SetProfilePicture(this.profilePhoto);

  @override
  List<Object?> get props => [profilePhoto];
}

class SetProfileLogoutEvent extends ProfileEvent {}

class OnGetProfileEvent extends ProfileEvent {}

class OnUpdateProfileEvent extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;

  const OnUpdateProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
      ];
}
