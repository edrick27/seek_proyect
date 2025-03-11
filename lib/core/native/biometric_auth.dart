import 'package:pigeon/pigeon.dart';

class AuthResult {
  bool? success;
  String? message;
}

@HostApi()
abstract class BiometricAuthApi {
  AuthResult authenticate(String reason);
}
