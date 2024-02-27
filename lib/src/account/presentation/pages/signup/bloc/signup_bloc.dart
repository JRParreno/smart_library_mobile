import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_libary_app/src/account/data/models/signup_model.dart';
import 'package:smart_libary_app/src/account/domain/repositories/signup_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository repository;

  SignupBloc(this.repository) : super(SignupInitial()) {
    on<OnSignupSubmit>(onSignupSubmit);
  }

  Future<void> onSignupSubmit(
      OnSignupSubmit event, Emitter<SignupState> emit) async {
    emit(SignupLoading());

    try {
      final response = await repository.signup(event.signupModel);
      await repository.saveTokens(
          accessToken: response.data['access_token'],
          refreshToken: response.data['refresh_token']);

      emit(SignupSuccess());
    } catch (e) {
      final dynamic error = e;
      emit(SignupError(errorMessage: error['data']['error_message']));
    }
  }
}
