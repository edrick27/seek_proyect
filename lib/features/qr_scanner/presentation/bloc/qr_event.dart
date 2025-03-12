import 'package:equatable/equatable.dart';
import '../../domain/entities/qr_scan_entity.dart';

abstract class QrEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Evento para cargar la lista de QR
class LoadQrList extends QrEvent {}

// Evento para agregar un nuevo QR
class AddQr extends QrEvent {
  final QrScanEntity qr;

  AddQr(this.qr);

  @override
  List<Object?> get props => [qr];
}
