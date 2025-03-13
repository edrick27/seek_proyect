import 'package:equatable/equatable.dart';

class BiometricAuthResult extends Equatable {
  final bool success;
  final String? errorMessage;

  const BiometricAuthResult({required this.success, this.errorMessage});

  @override
  List<Object?> get props => [success, errorMessage];
}
