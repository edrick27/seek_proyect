import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek_project/features/qr_scanner/domain/entities/qr_scan_entity.dart';
import 'package:seek_project/features/qr_scanner/presentation/bloc/qr_bloc.dart';
import 'package:seek_project/features/qr_scanner/presentation/bloc/qr_event.dart';
import 'package:seek_project/features/qr_scanner/presentation/bloc/qr_state.dart';
import 'package:seek_project/features/qr_scanner/presentation/widgets/qr_list_widget.dart';
import '../widgets/qr_scan_button.dart';

class QrScanPage extends StatefulWidget {
  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  String? _lastScannedCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escaneo QR'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final qr = QrScanEntity(
            id: '1',
            qrCode: 'https://www.google.com',
            scanTime: DateTime.now(),
            format: 'QR_CODE',
          );

          final qrBloc = context.read<QrBloc>();
          qrBloc.add(AddQr(qr));
        }, 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrScanButton(
              onScanSuccess: (code) {
                
                // setState(() {
                //   _lastScannedCode = code;
                // });
                // Puedes procesar el código QR aquí
              },
            ),
            const SizedBox(height: 16),
            _listQrScans(),
            if (_lastScannedCode != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Código escaneado:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(_lastScannedCode!),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _listQrScans() {

    return Container(
      color: Colors.red,
      height: 200,
      child: BlocBuilder<QrBloc, QrState>(
        builder: (context, state) {
          if (state is QrLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QrLoaded) {
            return QrListWidget(qrList: state.qrList);
          } else if (state is QrError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No hay códigos QR guardados'));
        },
      ),
    );
  }
}