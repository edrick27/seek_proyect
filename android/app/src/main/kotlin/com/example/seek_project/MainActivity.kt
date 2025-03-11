package com.example.seek_project

import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        BiometricAuthApi.setUp(flutterEngine.dartExecutor.binaryMessenger, BiometricAuthApiImpl(this))
    }
}
