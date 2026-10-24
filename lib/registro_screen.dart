import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_routes.dart';
import 'package:flutter_application_1/core/utils/validators.dart';
import 'package:flutter_application_1/core/widgets/widgets.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _nombreCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  final _contrasenaCtrl = TextEditingController();
  final _confirmarCtrl = TextEditingController();

  bool _aceptaTerminos = false;

  String? _errorNombre;
  String? _errorCorreo;
  String? _errorContrasena;
  String? _errorConfirmar;
  String? _errorTerminos;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _correoCtrl.dispose();
    _contrasenaCtrl.dispose();
    _confirmarCtrl.dispose();
    super.dispose();
  }

  void _crearCuenta() {
    final errNombre =
        Validators.requerido(_nombreCtrl.text, 'El nombre');
    final errCorreo = Validators.correo(_correoCtrl.text);
    final errContrasena =
        Validators.contrasenaBasica(_contrasenaCtrl.text);
    final errConfirmar = Validators.confirmarContrasena(
      _confirmarCtrl.text,
      _contrasenaCtrl.text,
    );
    final errTerminos = _aceptaTerminos
        ? null
        : 'Debes aceptar los términos y condiciones';

    setState(() {
      _errorNombre = errNombre;
      _errorCorreo = errCorreo;
      _errorContrasena = errContrasena;
      _errorConfirmar = errConfirmar;
      _errorTerminos = errTerminos;
    });

    final todoValido = errNombre == null &&
        errCorreo == null &&
        errContrasena == null &&
        errConfirmar == null &&
        errTerminos == null;

    if (todoValido) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
        arguments: _correoCtrl.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FondoDecorativo(
      esquema: EsquemaFondo.amarilloNaranja,
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
              const Text(
                'Crea tu cuenta',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                'Completa tus datos para empezar',
                style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 28),

              // ── Campos ──────────────────────────────────────────────────
              CampoTexto(
                etiqueta: 'Nombre completo',
                hint: 'Juan Pérez',
                icono: Icons.person_outline,
                controlador: _nombreCtrl,
                error: _errorNombre,
                textInputAction: TextInputAction.next,
                onChanged: (_) => setState(() => _errorNombre = null),
              ),
              const SizedBox(height: 16),
              CampoTexto(
                etiqueta: 'Correo electrónico',
                hint: 'tu@correo.com',
                icono: Icons.email_outlined,
                controlador: _correoCtrl,
                error: _errorCorreo,
                tipoTeclado: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (_) => setState(() => _errorCorreo = null),
              ),
              const SizedBox(height: 16),
              CampoTexto(
                etiqueta: 'Contraseña',
                hint: 'Mínimo 8 caracteres',
                icono: Icons.lock_outline,
                esContrasena: true,
                controlador: _contrasenaCtrl,
                error: _errorContrasena,
                textInputAction: TextInputAction.next,
                onChanged: (_) => setState(() => _errorContrasena = null),
              ),
              const SizedBox(height: 16),
              CampoTexto(
                etiqueta: 'Confirmar contraseña',
                hint: 'Repite tu contraseña',
                icono: Icons.lock_outline,
                esContrasena: true,
                controlador: _confirmarCtrl,
                error: _errorConfirmar,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _crearCuenta(),
                onChanged: (_) => setState(() => _errorConfirmar = null),
              ),
              const SizedBox(height: 16),

              // ── Checkbox de términos ─────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _aceptaTerminos,
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: AppColors.pink,
                      onChanged: (v) => setState(() {
                        _aceptaTerminos = v ?? false;
                        _errorTerminos = null;
                      }),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Acepto los Términos y condiciones y la Política de privacidad',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              if (_errorTerminos != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 34),
                  child: Text(
                    _errorTerminos!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 24),

              BotonPrincipal(texto: 'Crear cuenta', onPressed: _crearCuenta),
              const SizedBox(height: 16),

              // ── Pie ──────────────────────────────────────────────────────
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    '¿Ya tienes cuenta?',
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
