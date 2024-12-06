import 'dart:async';

import 'package:convo_sphere/features/authentication/domain/usecases/login_use_case.dart';
import 'package:convo_sphere/features/authentication/domain/usecases/register_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.registerUseCase,
    required this.loginUseCase,
  }) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
  }

  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final _storage = const FlutterSecureStorage();

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await registerUseCase.call(
        event.username,
        event.email,
        event.password,
      );

      if (user != null) {
        emit(AuthSuccess(message: 'Registration Successfully'));
      } else {
        emit(AuthFailure(error: 'Registration Failed'));
      }
    } catch (_) {
      emit(AuthFailure(error: 'Registration Failed'));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await loginUseCase.call(event.email, event.password);

      if (user != null) {
        _storage.write(key: 'token', value: user.token);
        _storage.write(key: 'userId', value: user.id);
        emit(AuthSuccess(message: 'Login Successfully'));
      } else {
        emit(AuthFailure(error: 'Login Failed'));
      }
    } catch (_) {
      emit(AuthFailure(error: 'Login Failed'));
    }
  }
}
