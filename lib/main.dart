import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstore/localstore.dart';
import 'package:seek_project/features/auth/data/datasources/biometric_auth_datasource.dart';
import 'package:seek_project/features/auth/infrastructure/biometric_auth_service.dart';
import 'package:seek_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:seek_project/features/auth/presentation/bloc/auth_state.dart';
import 'package:seek_project/features/auth/presentation/pages/biometric_login_page.dart';
import 'package:seek_project/features/qr_scanner/data/datasources/qr_scan_local_datasource.dart';
import 'package:seek_project/features/qr_scanner/data/repositories/qr_scan_repository_impl.dart';
import 'package:seek_project/features/qr_scanner/domain/usecases/get_all_scans_usecase.dart';
import 'package:seek_project/features/qr_scanner/domain/usecases/save_qr_scan_usecase.dart';
import 'package:seek_project/features/qr_scanner/presentation/bloc/qr_bloc.dart';
import 'package:seek_project/features/qr_scanner/presentation/bloc/qr_event.dart';
import 'package:seek_project/features/qr_scanner/presentation/pages/qr_scan_page.dart';
import 'package:uuid/uuid.dart';

void main() {

  final _db = Localstore.getInstance(useSupportDir: true);
  final qrDatasource = QrScanLocalDataSourceImpl(db: _db, uuid: Uuid());
  final qrRepository = QrScanRepositoryImpl(localDataSource: qrDatasource);

  final biometricAuthService = BiometricAuthService(); 
  final authDatasource = BiometricAuthDatasource(biometricAuthService: biometricAuthService);

  runApp(MyApp(
    qrRepository: qrRepository,
    authDatasource: authDatasource
  ));
}

class MyApp extends StatelessWidget {

  final QrScanRepositoryImpl qrRepository;
  final BiometricAuthDatasource authDatasource;

  const MyApp({
    super.key, 
    required this.qrRepository,
    required this.authDatasource
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => QrBloc(
            getQrList: GetAllScansUseCase(qrRepository), 
            saveQr: SaveQrScanUseCase(qrRepository)
          )..add(LoadQrList()), // Cargar la lista de QR al iniciar
        ),
        BlocProvider(
          create: (_) => AuthBloc(biometricAuthDatasource: authDatasource),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: QrScanPage(),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return QrScanPage();
            } else {
              return const BiometricLoginPage();
            }
          },
        ),
      ),
    );
  }
}
