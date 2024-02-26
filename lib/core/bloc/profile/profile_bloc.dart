import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_libary_app/core/bloc/common/common_event.dart';
import 'package:smart_libary_app/core/bloc/common/common_state.dart';
import 'package:smart_libary_app/core/local_storage/local_storage.dart';
import 'package:smart_libary_app/src/account/domain/entities/profile.dart';
import 'package:smart_libary_app/src/account/domain/repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(const InitialState()) {
    on<InitialEvent>(_initial);
    on<SetProfileEvent>(_setProfile);
    on<SetProfileLogoutEvent>(_setProfileLogoutEvent);
    on<SetProfilePicture>(_setProfilePicture);
    on<OnGetProfileEvent>(_onGetProfileEvent);
  }

  void _initial(InitialEvent event, Emitter<ProfileState> emit) {
    return emit(const InitialState());
  }

  Future<void> _setProfile(
      SetProfileEvent event, Emitter<ProfileState> emit) async {
    final user = await LocalStorage.readLocalStorage('_user');
    if (user != null) {
      final response = await repository.getUserProfile();
      emit(ProfileLoaded(profile: response));
      // await registerFcmToken();
      return;
    } else {
      await LocalStorage.deleteLocalStorage('_user');
      await LocalStorage.deleteLocalStorage('_refreshToken');
      await LocalStorage.deleteLocalStorage('_token');
      await LocalStorage.deleteLocalStorage('_whiteList');
    }
    return emit(const InitialState());
  }

  void _setProfileLogoutEvent(
      SetProfileLogoutEvent event, Emitter<ProfileState> emit) async {
    return emit(ProfileLogout());
  }

  void _setProfilePicture(SetProfilePicture event, Emitter<ProfileState> emit) {
    final state = this.state;

    if (state is ProfileLoaded) {
      return emit(
        ProfileLoaded(
          profile: state.profile.copyWith(profilePhoto: event.profilePhoto),
        ),
      );
    }
  }

  void _onGetProfileEvent(
      OnGetProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());

      final response = await repository.getUserProfile();
      await LocalStorage.storeLocalStorage('_user', response.toString());

      emit(ProfileLoaded(profile: response));
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }

  Future<void> registerFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    if (token != null) {
      await repository.setPushToken(token).catchError((onError) {});
    }
  }
}
