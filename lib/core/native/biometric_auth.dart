import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/core/native/biometric_auth_api_generated.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/app/src/main/kotlin/com/example/seek_project/BiometricAuthApi.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/BiometricAuthApi.swift',
  swiftOptions: SwiftOptions(),
))

// Define los mensajes que se enviarán entre Flutter y el código nativo
class BiometricAuthResult {
  BiometricAuthResult({
    this.success,
    this.errorMessage,
  });
  
  bool? success;
  String? errorMessage;
}

// Define la API que implementará el código nativo
@HostApi()
abstract class BiometricAuthApi {
  // Verifica si el dispositivo tiene capacidades biométricas
  @async
  bool isBiometricAvailable();
  
  // Autentica al usuario usando biometría
  @async
  BiometricAuthResult authenticateUser(String reason);
}