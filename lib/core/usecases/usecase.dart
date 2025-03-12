import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

/// Interfaz base para todos los casos de uso
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Para casos de uso que no requieren parámetros
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

/// Parámetros para obtener escaneos recientes
class GetRecentScansParams extends Equatable {
  final int limit;

  GetRecentScansParams({this.limit = 10});

  @override
  List<Object> get props => [limit];
}

/// Parámetros para eliminar un escaneo
class DeleteScanParams extends Equatable {
  final String id;

  DeleteScanParams({required this.id});

  @override
  List<Object> get props => [id];
}