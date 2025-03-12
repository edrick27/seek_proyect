import '../../domain/entities/qr_scan_entity.dart';

class QrScanModel extends QrScanEntity {
  QrScanModel({
    required String id,
    required String? qrCode,
    required String? format,
    required DateTime scanTime,
    String? description,
  }) : super(
          id: id,
          qrCode: qrCode,
          format: format,
          scanTime: scanTime,
          description: description,
        );

  factory QrScanModel.fromEntity(QrScanEntity entity) {
    return QrScanModel(
      id: entity.id,
      qrCode: entity.qrCode,
      format: entity.format,
      scanTime: entity.scanTime,
      description: entity.description,
    );
  }

  // Convertir a mapa para Localstore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'qrCode': qrCode,
      'format': format,
      'scanTime': scanTime.millisecondsSinceEpoch,
      'description': description,
    };
  }

  // Crear desde mapa
  factory QrScanModel.fromMap(Map<String, dynamic> map) {
    return QrScanModel(
      id: map['id'],
      qrCode: map['qrCode'],
      format: map['format'],
      scanTime: DateTime.fromMillisecondsSinceEpoch(map['scanTime']),
      description: map['description'],
    );
  }
}
