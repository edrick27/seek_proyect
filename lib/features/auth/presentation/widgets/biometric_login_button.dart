// lib/widgets/biometric_login_button.dart
import 'package:flutter/material.dart';
import 'package:seek_project/features/auth/infrastructure/biometric_auth_service.dart';

class BiometricLoginButton extends StatefulWidget {
  final Function(bool success) onAuthResult;
  
  const BiometricLoginButton({Key? key, required this.onAuthResult}) : super(key: key);

  @override
  _BiometricLoginButtonState createState() => _BiometricLoginButtonState();
}

class _BiometricLoginButtonState extends State<BiometricLoginButton> {
  final BiometricAuthService _authService = BiometricAuthService();
  bool _isAvailable = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    final isAvailable = await _authService.isBiometricAvailable();
    setState(() {
      _isAvailable = isAvailable;
      _isLoading = false;
    });
  }

  Future<void> _authenticate() async {
    final result = await _authService.authenticateUser(
      reason: 'Autentícate para acceder a la aplicación',
    );
    
    widget.onAuthResult(result.success ?? false);
    
    if (result.success != true && result.errorMessage != null) {
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
      return const SizedBox.shrink(); // No mostrar nada si la biometría no está disponible
    }
    
    return ElevatedButton.icon(
      icon: const Icon(Icons.fingerprint),
      label: const Text('Iniciar sesión con biometría'),
      onPressed: _authenticate,
    );
  }
}