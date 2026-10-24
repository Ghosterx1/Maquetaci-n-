# Flutter Application 1 - Auth App

Aplicación Flutter para autenticación con pantallas de login, registro, recuperación de contraseña, verificación por código y cambio de contraseña.

## Requisitos

Antes de ejecutar el proyecto, asegúrate de tener instalado lo siguiente:

- Flutter SDK 3.12.2 o compatible
- Dart SDK incluido con Flutter
- Android Studio o Xcode (según el sistema operativo)
- Un emulador o dispositivo físico conectado
- Git (opcional, para clonar el repositorio)

## Versiones recomendadas

Este proyecto está configurado con:

- Flutter: 3.12.2
- Dart: compatible con Flutter 3.12.2
- SDK mínimo definido en `pubspec.yaml`: `^3.12.2`

Puedes verificar tus versiones con:

```bash
flutter --version
dart --version
```

Si tu versión de Flutter es anterior, se recomienda actualizarla a una compatible con este proyecto.

## Clonar e iniciar

```bash
git clone <URL_DEL_REPOSITORIO>
cd flutter_application_1
flutter pub get
```

## Ejecutar la aplicación

### En un emulador o dispositivo conectado

```bash
flutter run
```

### Ejecutar en Chrome/Web

```bash
flutter run -d chrome
```

### Ejecutar Android

```bash
flutter devices
flutter run -d <device_id>
```

## Ejecutar pruebas

```bash
flutter test
```

## Solución de problemas comunes

### Error de dependencias

Si aparece un problema con dependencias o paquetes:

```bash
flutter clean
flutter pub get
```

### Error de SDK no compatible

Si Flutter o Dart no coincide con la versión esperada:

```bash
flutter upgrade
flutter doctor
```

### No se detecta un emulador

Verifica que tengas Android Studio con el SDK y el emulador instalado, y luego:

```bash
flutter devices
```

## Estructura principal

```text
lib/
  main.dart
  login_screen.dart
  registro_screen.dart
  recuperar_contrasena_screen.dart
  codigo_verificacion_screen.dart
  nueva_contrasena_screen.dart
  home_screen.dart
  core/
    constants/
    utils/
    widgets/
```

## Comandos útiles

```bash
flutter analyze
flutter test
flutter run
flutter build apk
```

## Nota

Este README está orientado a ejecutar el proyecto en entorno local con Flutter y Dart instalados correctamente. Si deseas, puedo dejarte también una versión con instrucciones específicas para Windows, Android o VS Code.
