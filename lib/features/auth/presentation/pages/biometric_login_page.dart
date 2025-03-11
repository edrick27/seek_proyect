import 'package:flutter/material.dart';

class BiometricLoginPage extends StatelessWidget {
  const BiometricLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autenticación Biométrica')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Aquí llamaremos la autenticación biométrica
          },
          child: const Text('Iniciar sesión con biometría'),
        ),
      ),
    );
  }
}
