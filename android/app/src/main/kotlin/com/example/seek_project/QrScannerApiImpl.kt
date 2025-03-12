package com.example.seek_project

import android.app.Activity
import android.content.Intent
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.fragment.app.FragmentActivity
import com.google.zxing.integration.android.IntentIntegrator
import io.flutter.plugin.common.PluginRegistry

import com.example.seek_project.QrScannerApi

class QrScannerApiImpl(private val activity: FragmentActivity) : QrScannerApi, PluginRegistry.ActivityResultListener {
    private var pendingResult: ((Result<QrScanResult>) -> Unit)? = null

    override fun scanQrCode(callback: (Result<QrScanResult>) -> Unit) {
        pendingResult = callback
        
        try {
            val integrator = IntentIntegrator(activity)
            integrator.setDesiredBarcodeFormats(IntentIntegrator.QR_CODE)
            integrator.setPrompt("Apunta al código QR")
            integrator.setCameraId(0)  // Cámara trasera
            integrator.setBeepEnabled(true)
            integrator.setBarcodeImageEnabled(false)
            integrator.initiateScan()
        } catch (e: Exception) {
            val result = QrScanResult(code = null, format = null, errorMessage = e.message)
            callback(Result.success(result))
            pendingResult = null
        }
    }
    
    override fun isQrScanAvailable(callback: (Result<Boolean>) -> Unit) {
        // Considera si el dispositivo tiene cámara
        val isAvailable = activity.packageManager.hasSystemFeature("android.hardware.camera")
        callback(Result.success(isAvailable))
    }
    
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        val result = IntentIntegrator.parseActivityResult(requestCode, resultCode, data)
        
        if (result != null) {
            if (result.contents == null) {
                // Cancelado
                pendingResult?.let {
                    val scanResult = QrScanResult(code = null, format = null, errorMessage = "Escaneo cancelado")
                    it(Result.success(scanResult))
                }
            } else {
                // Exitoso
                pendingResult?.let {
                    val scanResult = QrScanResult(
                        code = result.contents,
                        format = result.formatName,
                        errorMessage = null
                    )
                    it(Result.success(scanResult))
                }
            }
            pendingResult = null
            return true
        }
        return false
    }
}