import 'package:flutter/material.dart';
import 'package:seek_project/features/qr_scanner/domain/entities/qr_scan_entity.dart';

class QrListWidget extends StatelessWidget {
  final List<QrScanEntity> qrList;

  const QrListWidget({super.key, required this.qrList});

  @override
  Widget build(BuildContext context) {

    if (qrList.isEmpty) {
      return const Center(
        child: Text(
          'No hay QR escaneados',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        )
      );
    }

    return ListView.builder(
      itemCount: qrList.length,
      itemBuilder: (context, index) {
        final qr = qrList[index];
        return _cardQR(qr);
      },
    );
  }

  Widget _cardQR(QrScanEntity qr) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          child: ListTile(
            leading: const Icon(
              Icons.qr_code,
              size: 40.0,
              color: Colors.blue,
            ),
            title: Text(
              qr.qrCode ?? '',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              _formatDate(qr.scanTime),
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {

    final dateNow = DateTime;

    return '${date.hour}:${date.minute} ${date.day}/${date.month}/${date.year}';
  }
}
