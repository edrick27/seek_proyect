# QR Scanner App

Una aplicación móvil desarrollada en Flutter que permite a los usuarios realizar escaneo de códigos QR y utilizar autenticación biométrica (Face ID/Huella Digital).

## Demostración

Para ver la aplicación en funcionamiento, accede al siguiente enlace:

🎬 [Ver demostración de la aplicación](https://drive.google.com/file/d/1YSbhqzZ4G5RXzyUnXm3yBY8OPioC6eTd/view?usp=sharing)

🎬 [Ver Autentificación biometrica](https://drive.google.com/file/d/11VfmUQkh3vvVLFeVdq1zL4cAFJHfQ-7N/view?usp=sharing)

## Características

- 📱 Interfaz de usuario intuitiva y moderna
- 📷 Escaneo de códigos QR utilizando la cámara del dispositivo
- 🔐 Autenticación biométrica (Face ID en iOS, Huella Digital en Android)
- 📊 Historial persistente de códigos QR escaneados
- 🔄 Procesamiento nativo para optimizar el rendimiento

## Arquitectura y Tecnologías

- Arquitectura Limpia (Clean Architecture)
- Gestión de estado con BLoC
- Integración de código nativo mediante Pigeon

## Requisitos previos

- Flutter SDK (versión 3.24.3 o superior)
- Dart SDK (versión 3.5.3 o superior)
- Android Studio
- Un dispositivo físico o emulador con soporte para cámara y autenticación biométrica

## Configuración e instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/edrick27/seek_proyect.git
cd seek_proyect
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Ejecutar la aplicación

```bash
flutter run
```


## Estructura del proyecto

```
lib/
│   
├── features/
│   ├── auth/
│   │   └── ... # Módulo de autenticación biométrica
│   └── qr_scanner/
│       └── ... # Módulo de escaneo de códigos QR
├── core/
│   └── ... # Componentes reutilizables y utilidades
└── main.dart
```


## Notas adicionales

- La autenticación biométrica requiere que el dispositivo tenga configurado al menos un método biométrico (huella digital).
- Para el correcto funcionamiento del escáner QR, la aplicación solicitará permisos de cámara durante la primera ejecución.
