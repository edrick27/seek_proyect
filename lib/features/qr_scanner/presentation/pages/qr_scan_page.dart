import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:seek_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:seek_project/features/auth/presentation/pages/biometric_login_page.dart';
import 'package:seek_project/features/qr_scanner/domain/entities/qr_scan_entity.dart';
import 'package:seek_project/features/qr_scanner/presentation/bloc/qr_bloc.dart';
import 'package:seek_project/features/qr_scanner/presentation/bloc/qr_event.dart';
import 'package:seek_project/features/qr_scanner/presentation/bloc/qr_state.dart';
import 'package:seek_project/features/qr_scanner/presentation/widgets/qr_list_widget.dart';
import 'package:uuid/uuid.dart';
import '../widgets/qr_scan_button.dart';

class QrScanPage extends StatefulWidget {
  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escaneo QR'),
        actions: [
          _logoutButton(),
        ],
      ),
      floatingActionButton: QrScanButton(
        onScanSuccess: (code) {
          
          final qr = QrScanEntity(
            id: const Uuid().v4(),
            qrCode: code,
            scanTime: DateTime.now(),
            format: 'QR_CODE',
          );

          final qrBloc = context.read<QrBloc>();
          qrBloc.add(AddQr(qr));
        },
      ),
      body: Center(
        child: _listQrScans(),
      ),
    );
  }

  Widget _listQrScans() {

    return Container(
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

  Widget _logoutButton() {
    return IconButton(
      icon: const Icon(
        Icons.logout,
        color: Colors.red,
      ),
      onPressed: () {
        context.read<AuthBloc>().add(LogoutUser());

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const BiometricLoginPage()),
        );
      },
    );
  }
}