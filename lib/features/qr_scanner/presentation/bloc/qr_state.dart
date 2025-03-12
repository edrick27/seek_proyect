import 'package:equatable/equatable.dart';
import 'package:seek_project/features/qr_scanner/domain/entities/qr_scan_entity.dart';

abstract class QrState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Estado inicial vacío
class QrInitial extends QrState {}

// Estado cuando se está cargando la lista
class QrLoading extends QrState {}

// Estado cuando se cargó la lista correctamente
class QrLoaded extends QrState {
  final List<QrScanEntity> qrList;

  QrLoaded(this.qrList);

  @override
  List<Object?> get props => [qrList];
}

// Estado de error
class QrError extends QrState {
  final String message;

  QrError(this.message);

  @override
  List<Object?> get props => [message];
}
