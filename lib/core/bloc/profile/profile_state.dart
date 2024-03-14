part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  final Profile profile;
  final bool isLoading;
  final String? errorMessage;

  const ProfileLoaded({
    required this.profile,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        profile,
        isLoading,
        errorMessage,
      ];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'profile': profile.toMap()});
    result.addAll({'isLoading': isLoading});
    if (errorMessage != null) {
      result.addAll({'errorMessage': errorMessage});
    }

    return result;
  }

  factory ProfileLoaded.fromMap(Map<String, dynamic> map) {
    return ProfileLoaded(
      profile: Profile.fromMap(map['profile']),
      isLoading: map['isLoading'] ?? false,
      errorMessage: map['errorMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileLoaded.fromJson(String source) =>
      ProfileLoaded.fromMap(json.decode(source));

  ProfileLoaded copyWith({
    Profile? profile,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ProfileLogout extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String errorMessage;
  const ProfileError({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
