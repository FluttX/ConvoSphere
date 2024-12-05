part of 'auth_bloc.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  AuthSuccess({required this.message});

  final String message;
}

final class AuthFailure extends AuthState {
  AuthFailure({required this.error});

  final String error;
}
