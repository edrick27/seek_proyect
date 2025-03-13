import 'package:seek_project/features/auth/infrastructure/biometric_auth_service.dart';
import '../../domain/entities/biometric_auth_result.dart';

class BiometricAuthDatasource {
  final BiometricAuthService biometricAuthService;

  BiometricAuthDatasource({required this.biometricAuthService});

  Future<bool> isBiometricAvailable() async {
    return await biometricAuthService.isBiometricAvailable();
  }

  Future<BiometricAuthResult> authenticate() async {
    final result = await biometricAuthService.authenticateUser();

    return BiometricAuthResult(
      success: result.success ?? false,
      errorMessage: result.errorMessage,
    );
  }
}
