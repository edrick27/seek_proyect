import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_all_scans_usecase.dart';
import '../../domain/usecases/save_qr_scan_usecase.dart';
import 'qr_event.dart';
import 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  final GetAllScansUseCase getQrList;
  final SaveQrScanUseCase saveQr;

  QrBloc({
    required this.getQrList,
    required this.saveQr,
  }) : super(QrInitial()) {
    on<LoadQrList>(_onLoadQrList);
    on<AddQr>(_onAddQr);
  }

  Future<void> _onLoadQrList(LoadQrList event, Emitter<QrState> emit) async {
    emit(QrLoading());
    final qrList = await getQrList();
    emit(QrLoaded(qrList));
  }

  Future<void> _onAddQr(AddQr event, Emitter<QrState> emit) async {
    await saveQr(event.qr);
    add(LoadQrList()); // Recargar la lista
  }
}
