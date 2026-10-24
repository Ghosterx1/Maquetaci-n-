import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_routes.dart';
import 'package:flutter_application_1/core/utils/validators.dart';
import 'package:flutter_application_1/core/widgets/widgets.dart';

class RecuperarContrasenaScreen extends StatefulWidget {
  const RecuperarContrasenaScreen({super.key});

  @override
  State<RecuperarContrasenaScreen> createState() =>
      _RecuperarContrasenaScreenState();
}

class _RecuperarContrasenaScreenState
    extends State<RecuperarContrasenaScreen> {
  final _correoCtrl = TextEditingController();
  String? _errorCorreo;

  @override
  void dispose() {
    _correoCtrl.dispose();
    super.dispose();
  }

  void _enviarCodigo() {
    final error = Validators.correo(_correoCtrl.text);
    setState(() => _errorCorreo = error);

    if (error == null) {
      Navigator.pushNamed(
        context,
        AppRoutes.codigo,
        arguments: _correoCtrl.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FondoDecorativo(
      esquema: EsquemaFondo.azulMorado,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 12),

              // ── Ícono de pantalla ────────────────────────────────────────
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: AppColors.blueGradient,
                ),
                child: const Icon(
                  Icons.mark_email_unread_outlined,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Ingresa el correo con el que te registraste y te enviaremos un código de 4 dígitos.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 28),

              CampoTexto(
                etiqueta: 'Correo electrónico',
                hint: 'tu@correo.com',
                icono: Icons.email_outlined,
                controlador: _correoCtrl,
                error: _errorCorreo,
                tipoTeclado: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _enviarCodigo(),
                onChanged: (_) => setState(() => _errorCorreo = null),
              ),
              const SizedBox(height: 28),

              BotonPrincipal(texto: 'Enviar código', onPressed: _enviarCodigo),
              const SizedBox(height: 16),

              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    '¿La recordaste?',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Inicia sesión',
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
