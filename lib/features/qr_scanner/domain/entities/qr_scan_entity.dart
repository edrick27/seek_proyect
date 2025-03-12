class QrScanEntity {
  final String id;
  final String? qrCode;
  final String? format;
  final DateTime scanTime;
  final String? description;

  QrScanEntity({
    required this.id,
    required this.qrCode,
    required this.format,
    required this.scanTime,
    this.description,
  });
}