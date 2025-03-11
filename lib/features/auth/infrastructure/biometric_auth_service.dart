// lib/services/biometric_auth_service.dart
import 'package:flutter/services.dart';
import 'package:seek_project/core/native/biometric_auth_api_generated.dart';
// Importa el archivo generado por Pigeon

class BiometricAuthService {
  final BiometricAuthApi _api = BiometricAuthApi();
  
  Future<bool> isBiometricAvailable() async {
    try {
      return await _api.isBiometricAvailable();
    } on PlatformException catch (e) {
      print('Error al verificar disponibilidad biométrica: ${e.message}');
      return false;
    }
  }
  
  Future<BiometricAuthResult> authenticateUser({String reason = 'Autentícate para iniciar sesión'}) async {
    try {
      return await _api.authenticateUser(reason);
    } on PlatformException catch (e) {
      return BiometricAuthResult(
        success: false,
        errorMessage: 'Error: ${e.message}',
      );
    }
  }
}