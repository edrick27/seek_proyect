package com.example.seek_project

import android.app.Activity
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import java.util.concurrent.Executor

import com.example.seek_project.BiometricAuthApi

class BiometricAuthApiImpl(private val activity: FragmentActivity) : BiometricAuthApi {
    private val executor: Executor = ContextCompat.getMainExecutor(activity)

    override fun isBiometricAvailable(callback: (Result<Boolean>) -> Unit) {
        try {
            val biometricManager = BiometricManager.from(activity)
            val canAuthenticate = biometricManager.canAuthenticate(BiometricManager.Authenticators.BIOMETRIC_STRONG)
            val isAvailable = canAuthenticate == BiometricManager.BIOMETRIC_SUCCESS
            callback(Result.success(isAvailable))
        } catch (e: Exception) {
            callback(Result.failure(FlutterError("biometric_error", e.message, null)))
        }
    }

    override fun authenticateUser(reason: String, callback: (Result<BiometricAuthResult>) -> Unit) {
        try {
            val biometricPrompt = BiometricPrompt(activity, executor,
                object : BiometricPrompt.AuthenticationCallback() {
                    override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                        val result = BiometricAuthResult(false, errString.toString())
                        callback(Result.success(result))
                    }

                    override fun onAuthenticationSucceeded(authResult: BiometricPrompt.AuthenticationResult) {
                        val result = BiometricAuthResult(true, null)
                        callback(Result.success(result))
                    }

                    override fun onAuthenticationFailed() {
                        val result = BiometricAuthResult(false, "Autenticación biométrica fallida")
                        callback(Result.success(result))
                    }
                })

            val promptInfo = BiometricPrompt.PromptInfo.Builder()
                .setTitle("Iniciar Sesión")
                .setSubtitle("Autentícate para acceder")
                .setDescription(reason)
                .setNegativeButtonText("Cancelar")
                .setAllowedAuthenticators(BiometricManager.Authenticators.BIOMETRIC_STRONG)
                .build()

            biometricPrompt.authenticate(promptInfo)
        } catch (e: Exception) {
            callback(Result.failure(FlutterError("biometric_error", e.message, null)))
        }
    }
}

// En tu MainActivity o FlutterActivity:
// Agrega el siguiente código en tu clase MainActivity

/*
class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        BiometricAuthApi.setUp(flutterEngine.dartExecutor.binaryMessenger, BiometricAuthApiImpl(this))
    }
}
*/