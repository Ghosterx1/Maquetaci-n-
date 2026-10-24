import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_routes.dart';
import 'package:flutter_application_1/core/utils/password_strength.dart';
import 'package:flutter_application_1/core/widgets/widgets.dart';

class NuevaContrasenaScreen extends StatefulWidget {
  const NuevaContrasenaScreen({super.key});

  @override
  State<NuevaContrasenaScreen> createState() => _NuevaContrasenaScreenState();
}

class _NuevaContrasenaScreenState extends State<NuevaContrasenaScreen> {
  final _contrasenaCtrl = TextEditingController();
  final _confirmarCtrl = TextEditingController();
  String? _errorConfirmar;

  @override
  void dispose() {
    _contrasenaCtrl.dispose();
    _confirmarCtrl.dispose();
    super.dispose();
  }

  // ── Getters de validación ────────────────────────────────────────────────

  bool get _coinciden =>
      _confirmarCtrl.text.isNotEmpty &&
      _confirmarCtrl.text == _contrasenaCtrl.text;

  bool get _todoValido =>
      passwordRequirements.every((r) => r.isMet(_contrasenaCtrl.text)) &&
      _coinciden;

  // ── Acciones ─────────────────────────────────────────────────────────────

  void _restablecer() {
    if (!_todoValido) {
      setState(() {
        _errorConfirmar = _coinciden ? null : 'Las contraseñas no coinciden';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cumple todos los requisitos y confirma la contraseña'),
        ),
      );
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
      arguments: '¡Contraseña actualizada! Ya puedes iniciar sesión.',
    );
  }

  // ── Builders ─────────────────────────────────────────────────────────────

  Widget _buildRequisito(PasswordRequirement req) {
    final cumple = req.isMet(_contrasenaCtrl.text);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              cumple ? Icons.check_circle : Icons.radio_button_unchecked,
              key: ValueKey(cumple),
              size: 20,
              color: cumple ? AppColors.greenSuccess : Colors.grey.shade400,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            req.label,
            style: TextStyle(
              fontSize: 14,
              color: cumple ? Colors.green.shade700 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FondoDecorativo(
      esquema: EsquemaFondo.moradoRosa,
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
              const SizedBox(height: 8),

              // ── Etiqueta de código verificado ────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.greenSuccessBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.greenSuccess,
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Código verificado',
                      style: TextStyle(
                        color: AppColors.greenSuccess,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ── Ícono de pantalla ────────────────────────────────────────
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: AppColors.blueGradient,
                ),
                child: const Icon(
                  Icons.lock_reset,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Crea una nueva contraseña',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Tu nueva contraseña debe ser diferente a las que usaste antes.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),

              CampoTexto(
                etiqueta: 'Nueva contraseña',
                hint: '••••••',
                icono: Icons.lock_outline,
                esContrasena: true,
                controlador: _contrasenaCtrl,
                textInputAction: TextInputAction.next,
                onChanged: (_) => setState(() => _errorConfirmar = null),
              ),
              const SizedBox(height: 16),
              CampoTexto(
                etiqueta: 'Confirmar contraseña',
                hint: '••••••',
                icono: Icons.lock_outline,
                esContrasena: true,
                controlador: _confirmarCtrl,
                error: _errorConfirmar,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _restablecer(),
                onChanged: (_) => setState(() => _errorConfirmar = null),
              ),
              const SizedBox(height: 16),

              // ── Lista de requisitos ──────────────────────────────────────
              ...passwordRequirements.map(_buildRequisito),
              const SizedBox(height: 24),

              BotonPrincipal(
                texto: 'Restablecer contraseña',
                habilitado: _todoValido,
                onPressed: _restablecer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
