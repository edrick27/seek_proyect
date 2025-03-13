import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:seek_project/features/auth/presentation/bloc/auth_event.dart';
import 'package:seek_project/features/auth/presentation/bloc/auth_state.dart';

class BiometricLoginButton extends StatefulWidget {
  const BiometricLoginButton({Key? key}) : super(key: key);

  @override
  _BiometricLoginButtonState createState() => _BiometricLoginButtonState();
}

class _BiometricLoginButtonState extends State<BiometricLoginButton> {
  bool _isAvailable = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    final authBloc = context.read<AuthBloc>();
    final isAvailable = await authBloc.biometricAuthDatasource.isBiometricAvailable();

    setState(() {
      _isAvailable = isAvailable;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const CircularProgressIndicator();
    }
    
    if (!_isAvailable) {
      return const SizedBox.shrink(); // No mostrar nada si la biometría no está disponible
    }

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton.icon(
          icon: const Icon(Icons.fingerprint),
          label: const Text('Iniciar sesión con biometría'),
          onPressed: state is AuthLoading
              ? null
              : () {
                  context.read<AuthBloc>().add(AuthenticateUser());
                },
        );
      },
    );
  }
}
