/// Excepción lanzada cuando hay un error en el servidor
class ServerException implements Exception {
  final String? message;

  ServerException({this.message});
}

/// Excepción lanzada cuando hay un error en el almacenamiento local
class CacheException implements Exception {
  final String? message;

  CacheException({this.message});
}

/// Excepción lanzada cuando no hay conexión a Internet
class NetworkException implements Exception {
  final String? message;

  NetworkException({this.message});
}