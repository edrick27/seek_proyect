import 'package:equatable/equatable.dart';

/// Clase base para todos los fallos en la aplicación
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

/// Fallo cuando ocurre un error en el servidor
class ServerFailure extends Failure {}

/// Fallo cuando ocurre un error en el almacenamiento local
class CacheFailure extends Failure {}

/// Fallo cuando el dispositivo no tiene conexión a Internet
class NetworkFailure extends Failure {}

/// Fallo genérico para errores inesperados
class UnexpectedFailure extends Failure {
  final String message;

  UnexpectedFailure({required this.message});

  @override
  List<Object> get props => [message];
}