import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Evento para intentar autenticación biométrica
class AuthenticateUser extends AuthEvent {}

// Evento para cerrar sesión
class LogoutUser extends AuthEvent {}
