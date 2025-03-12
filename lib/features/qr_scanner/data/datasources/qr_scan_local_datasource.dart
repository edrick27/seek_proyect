import '../models/qr_scan_model.dart';
import '../../../../core/error/exceptions.dart';
import 'package:localstore/localstore.dart';
import 'package:uuid/uuid.dart';

abstract class QrScanLocalDataSource {
  /// Guarda un nuevo escaneo QR
  Future<QrScanModel> saveQrScan(String? qrCode, String? format);
  
  /// Obtiene todos los escaneos guardados
  Future<List<QrScanModel>> getAllScans();
  
  /// Elimina un escaneo por ID
  Future<void> deleteScan(String id);
}

class QrScanLocalDataSourceImpl implements QrScanLocalDataSource {
  final Localstore db;
  final Uuid uuid;
  final String collection = 'qr_scans';

  QrScanLocalDataSourceImpl({
    required this.db,
    required this.uuid,
  });

  @override
  Future<QrScanModel> saveQrScan(String? qrCode, String? format) async {
    try {
      final id = uuid.v4();
      
      final model = QrScanModel(
        id: id,
        qrCode: qrCode,
        format: format,
        scanTime: DateTime.now(),
        description: null,
      );
      
      await db.collection(collection).doc(id).set(model.toMap());
      
      return model;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<QrScanModel>> getAllScans() async {
    try {
      final data = await db.collection(collection).get();
      
      if (data == null) return [];
      
      return data.entries
          .map((entry) => QrScanModel.fromMap(entry.value))
          .toList();
    } catch (e) {
      throw CacheException();
    }
  }


  @override
  Future<void> deleteScan(String id) async {
    try {
      await db.collection(collection).doc(id).delete();
    } catch (e) {
      throw CacheException();
    }
  }
}