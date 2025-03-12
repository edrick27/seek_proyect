import 'package:flutter/material.dart';
import 'package:seek_project/features/qr_scanner/domain/entities/qr_scan_entity.dart';

class QrListWidget extends StatelessWidget {
  final List<QrScanEntity> qrList;

  const QrListWidget({super.key, required this.qrList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: qrList.length,
      itemBuilder: (context, index) {
        final qr = qrList[index];
        return ListTile(
          leading: const Icon(Icons.qr_code),
          title: Text(qr.qrCode ?? ''),
          subtitle: Text(qr.scanTime.toString()),
        );
      },
    );
  }
}
