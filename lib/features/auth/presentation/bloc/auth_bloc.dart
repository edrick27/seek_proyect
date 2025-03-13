import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/biometric_auth_datasource.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BiometricAuthDatasource biometricAuthDatasource;

  AuthBloc({required this.biometricAuthDatasource}) : super(AuthInitial()) {
    on<AuthenticateUser>(_onAuthenticateUser);
    on<LogoutUser>(_onLogoutUser);
  }

  Future<void> _onAuthenticateUser(AuthenticateUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final isAuthenticated = await biometricAuthDatasource.authenticate();

    if (isAuthenticated.success) {
      emit(Authenticated());
    } else {
      emit(AuthError("Autenticación fallida"));
    }
  }

  void _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) {
    emit(Unauthenticated());
  }
}
