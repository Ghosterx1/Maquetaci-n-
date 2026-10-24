import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_routes.dart';
import 'package:flutter_application_1/core/utils/validators.dart';
import 'package:flutter_application_1/core/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.mensaje});

  final String? mensaje;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _correoCtrl = TextEditingController();
  final _contrasenaCtrl = TextEditingController();
  final _focusContrasena = FocusNode();

  String? _errorCorreo;
  String? _errorContrasena;

  @override
  void initState() {
    super.initState();
    // Mostrar mensaje de éxito (ej: contraseña actualizada) si existe.
    final msg = widget.mensaje;
    if (msg != null && msg.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: AppColors.greenSuccess,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _correoCtrl.dispose();
    _contrasenaCtrl.dispose();
    _focusContrasena.dispose();
    super.dispose();
  }

  void _iniciarSesion() {
    final errCorreo = Validators.correo(_correoCtrl.text);
    final errContrasena = Validators.contrasenaBasica(_contrasenaCtrl.text);

    setState(() {
      _errorCorreo = errCorreo;
      _errorContrasena = errContrasena;
    });

    if (errCorreo == null && errContrasena == null) {
      Navigator.pushNamed(
        context,
        AppRoutes.home,
        arguments: _correoCtrl.text.trim(),
      );
    }
  }

  void _noDisponible() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Funcionalidad no disponible')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FondoDecorativo(
      esquema: EsquemaFondo.moradoRosa,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // ── Logo ────────────────────────────────────────────────────
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: AppColors.primaryGradient,
                ),
                child: const Icon(
                  Icons.lock_outline,
                  size: 44,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Bienvenido de nuevo',
                style:
                    TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                'Inicia sesión para continuar',
                style:
                    TextStyle(fontSize: 15, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 28),

              // ── Formulario ──────────────────────────────────────────────
              CampoTexto(
                etiqueta: 'Correo electrónico',
                hint: 'tu@correo.com',
                icono: Icons.email_outlined,
                controlador: _correoCtrl,
                error: _errorCorreo,
                tipoTeclado: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => _focusContrasena.requestFocus(),
                onChanged: (_) => setState(() => _errorCorreo = null),
              ),
              const SizedBox(height: 16),
              CampoTexto(
                etiqueta: 'Contraseña',
                hint: '••••••••',
                icono: Icons.lock_outline,
                esContrasena: true,
                controlador: _contrasenaCtrl,
                error: _errorContrasena,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _iniciarSesion(),
                onChanged: (_) => setState(() => _errorContrasena = null),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.recuperar),
                  child: const Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(
                      color: AppColors.purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),

              BotonPrincipal(
                texto: 'Iniciar sesión',
                onPressed: _iniciarSesion,
              ),
              const SizedBox(height: 28),

              // ── Divisor ─────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'o continúa con',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 20),

              // ── Botones sociales ─────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: BotonSecundario(
                      texto: 'Google',
                      icono: Icons.g_mobiledata,
                      onPressed: _noDisponible,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BotonSecundario(
                      texto: 'Apple',
                      icono: Icons.apple,
                      onPressed: _noDisponible,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Pie ──────────────────────────────────────────────────────
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    '¿No tienes cuenta?',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.registro),
                    child: const Text(
                      'Regístrate',
                      style: TextStyle(
                        color: AppColors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
