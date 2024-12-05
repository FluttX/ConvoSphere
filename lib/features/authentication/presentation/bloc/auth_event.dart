part of 'auth_bloc.dart';

abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  RegisterEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  final String username;
  final String email;
  final String password;
}

class LoginEvent extends AuthEvent {
  LoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
