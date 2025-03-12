import 'package:flutter/material.dart';
import 'package:seek_project/features/qr_scanner/infrastructure/qr_scanner_service.dart';

class QrScanButton extends StatefulWidget {
  final Function(String code) onScanSuccess;
  
  const QrScanButton({super.key, required this.onScanSuccess});

  @override
  _QrScanButtonState createState() => _QrScanButtonState();
}

class _QrScanButtonState extends State<QrScanButton> {
  final QrScannerService _scannerService = QrScannerService();
  bool _isAvailable = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAvailability();
  }

  Future<void> _checkAvailability() async {
    final isAvailable = await _scannerService.isQrScanAvailable();
    setState(() {
      _isAvailable = isAvailable;
      _isLoading = false;
    });
  }

  Future<void> _scanQrCode() async {
    final result = await _scannerService.scanQrCode();
    
    if (result.code != null) {

      
      widget.onScanSuccess(result.code!);
    } else if (result.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const CircularProgressIndicator();
    }
    
    if (!_isAvailable) {
      return const Text('Escaneo QR no disponible en este dispositivo');
    }
    
    return ElevatedButton.icon(
      icon: const Icon(Icons.qr_code_scanner),
      label: const Text('Escanear QR'),
      onPressed: _scanQrCode,
    );
  }
}