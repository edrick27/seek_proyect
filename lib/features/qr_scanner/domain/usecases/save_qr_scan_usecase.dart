import 'package:seek_project/features/qr_scanner/domain/entities/qr_scan_entity.dart';
import '../repositories/qr_scan_repository.dart';


class SaveQrScanUseCase {
  final QrScanRepository repository;

  SaveQrScanUseCase(this.repository);

  Future<void> call(QrScanEntity params) {
    return repository.saveQrScan(params.qrCode, params.format);
  }
}