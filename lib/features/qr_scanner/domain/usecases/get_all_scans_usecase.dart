import '../entities/qr_scan_entity.dart';
import '../repositories/qr_scan_repository.dart';

class GetAllScansUseCase {
  final QrScanRepository repository;

  GetAllScansUseCase(this.repository);

  Future<List<QrScanEntity>> call() {
    return repository.getAllScans();
  }
}