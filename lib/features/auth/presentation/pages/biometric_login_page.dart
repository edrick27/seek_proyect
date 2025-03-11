import 'package:flutter/material.dart';
import 'package:seek_project/features/auth/presentation/widgets/biometric_login_button.dart';

class BiometricLoginPage extends StatelessWidget {
  const BiometricLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autenticación Biométrica')),
      body: Center(
        child:  BiometricLoginButton(
          onAuthResult: (success) {
            if (success) {
              print('Prueba de autenticación exitosa');
              // Navigator.of(context).pushReplacementNamed('/home');
            } else {
              print('Prueba de autenticación fallida');
            }

          },
        ),
      ),
    );
  }
}
