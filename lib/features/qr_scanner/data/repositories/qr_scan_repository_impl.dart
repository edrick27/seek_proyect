import '../../domain/entities/qr_scan_entity.dart';
import '../../domain/repositories/qr_scan_repository.dart';
import '../datasources/qr_scan_local_datasource.dart';

class QrScanRepositoryImpl implements QrScanRepository {
  final QrScanLocalDataSource localDataSource;

  QrScanRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<void> saveQrScan(String? qrCode, String? format) async {
    await localDataSource.saveQrScan(qrCode, format);
  }

  @override
  Future<List<QrScanEntity>> getAllScans() async {
    final scanModels = await localDataSource.getAllScans();
    return scanModels;
  }
}