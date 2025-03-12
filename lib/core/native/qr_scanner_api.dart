// lib/qr_scanner_api.dart
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/qr_scanner_api_generated.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/app/src/main/kotlin/com/example/seek_project/QrScannerApi.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/QrScannerApi.swift',
  swiftOptions: SwiftOptions(),
))

class QrScanResult {
  QrScanResult({
    this.code,
    this.format,
    this.errorMessage,
  });
  
  String? code;
  String? format;
  String? errorMessage;
}

@HostApi()
abstract class QrScannerApi {
  // Inicia el escaneo de QR y devuelve el resultado
  @async
  QrScanResult scanQrCode();
  
  // Verifica si el escaneo QR está disponible
  @async
  bool isQrScanAvailable();
}