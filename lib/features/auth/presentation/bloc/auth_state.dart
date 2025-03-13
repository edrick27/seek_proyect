import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Estado inicial
class AuthInitial extends AuthState {}

// Estado cuando la autenticación está en progreso
class AuthLoading extends AuthState {}

// Estado cuando la autenticación fue exitosa
class Authenticated extends AuthState {}

// Estado cuando la autenticación falla
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// Estado cuando el usuario cierra sesión
class Unauthenticated extends AuthState {}

