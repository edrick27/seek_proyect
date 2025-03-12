import '../entities/qr_scan_entity.dart';

abstract class QrScanRepository {
  /// Guarda un nuevo escaneo QR
  Future<void> saveQrScan(String? qrCode, String? format);
  
  /// Obtiene todos los escaneos guardados
  Future<List<QrScanEntity>> getAllScans();
}