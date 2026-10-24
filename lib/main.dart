import 'package:flutter/material.dart';
import 'package:flutter_application_1/codigo_verificacion_screen.dart';
import 'package:flutter_application_1/core/constants/app_routes.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/login_screen.dart';
import 'package:flutter_application_1/nueva_contrasena_screen.dart';
import 'package:flutter_application_1/recuperar_contrasena_screen.dart';
import 'package:flutter_application_1/registro_screen.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorSchemeSeed: const Color(0xFF7B2FF7),
      ),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (ctx) => LoginScreen(
              mensaje: ModalRoute.of(ctx)!.settings.arguments as String?,
            ),
        AppRoutes.registro: (_) => const RegistroScreen(),
        AppRoutes.recuperar: (_) => const RecuperarContrasenaScreen(),
        AppRoutes.codigo: (ctx) => CodigoVerificacionScreen(
              correo:
                  ModalRoute.of(ctx)!.settings.arguments as String? ?? '',
            ),
        AppRoutes.nuevaContrasena: (_) => const NuevaContrasenaScreen(),
        AppRoutes.home: (ctx) => HomeScreen(
              correo:
                  ModalRoute.of(ctx)!.settings.arguments as String? ?? '',
            ),
      },
    );
  }
}
