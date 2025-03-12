import 'package:flutter/services.dart';
import 'package:seek_project/core/native/qr_scanner_api_generated.dart';

class QrScannerService {
  final QrScannerApi _api = QrScannerApi();
  
  Future<bool> isQrScanAvailable() async {
    try {
      return await _api.isQrScanAvailable();
    } on PlatformException catch (e) {
      print('Error al verificar disponibilidad del escáner QR: ${e.message}');
      return false;
    }
  }
  
  Future<QrScanResult> scanQrCode() async {
    try {
      return await _api.scanQrCode();
    } on PlatformException catch (e) {
      return QrScanResult(
        code: null,
        format: null,
        errorMessage: 'Error: ${e.message}',
      );
    }
  }
}