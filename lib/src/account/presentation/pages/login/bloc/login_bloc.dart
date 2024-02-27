import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_libary_app/src/account/domain/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<OnSubmitLoginEvent>(onSubmitLoginEvent);
  }

  Future<void> onSubmitLoginEvent(
      OnSubmitLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());

      final response = await repository.login(
          email: event.emailAddress, password: event.password);
      await repository.saveTokens(
          accessToken: response.data['access_token'],
          refreshToken: response.data['refresh_token']);
      emit(LoginSuccess());
    } catch (e) {
      final dynamic error = e;
      emit(LoginError(error['data']['error_description']));
    }
  }
}
