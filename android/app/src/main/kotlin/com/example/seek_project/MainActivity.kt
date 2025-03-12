package com.example.seek_project

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.PluginRegistry
import android.content.Intent

class MainActivity: FlutterFragmentActivity() {

    private lateinit var qrScannerImpl: QrScannerApiImpl

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Configurar la API de autenticación biométrica
        BiometricAuthApi.setUp(flutterEngine.dartExecutor.binaryMessenger, BiometricAuthApiImpl(this))

        // Configurar la API de escaneo QR
        qrScannerImpl = QrScannerApiImpl(this)
        QrScannerApi.setUp(flutterEngine.dartExecutor.binaryMessenger, qrScannerImpl)
    }

    // Este método interceptará los resultados de la actividad y los pasará a nuestro QrScannerApiImpl
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        
        // Simplemente delegamos al QrScannerApiImpl para que procese el resultado
        qrScannerImpl.onActivityResult(requestCode, resultCode, data)
    }
}