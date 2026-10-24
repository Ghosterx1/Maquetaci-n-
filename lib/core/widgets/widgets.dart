import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

enum EsquemaFondo {
  amarilloNaranja,
  moradoRosa,
  azulMorado,
  rosaCalido,
}

class FondoDecorativo extends StatelessWidget {
  const FondoDecorativo({
    super.key,
    required this.child,
    required this.esquema,
  });

  final Widget child;
  final EsquemaFondo esquema;

  LinearGradient get _gradient {
    switch (esquema) {
      case EsquemaFondo.amarilloNaranja:
        return const LinearGradient(
          colors: [Color(0xFFFFF7ED), Color(0xFFFDE68A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case EsquemaFondo.moradoRosa:
        return const LinearGradient(
          colors: [Color(0xFFFDF2F8), Color(0xFFE9D5FF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case EsquemaFondo.azulMorado:
        return const LinearGradient(
          colors: [Color(0xFFE0F2FE), Color(0xFFEDE9FE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case EsquemaFondo.rosaCalido:
        return const LinearGradient(
          colors: [Color(0xFFFFF1F2), Color(0xFFFCE7F3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: _gradient),
        child: Stack(
          children: [
            Positioned(
              top: -70,
              right: -40,
              width: 220,
              height: 220,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -35,
              width: 220,
              height: 220,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned.fill(child: child),
          ],
        ),
      ),
    );
  }
}

class CampoTexto extends StatelessWidget {
  const CampoTexto({
    super.key,
    required this.etiqueta,
    this.hint,
    this.icono,
    this.controlador,
    this.error,
    this.esContrasena = false,
    this.tipoTeclado = TextInputType.text,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
  });

  final String etiqueta;
  final String? hint;
  final IconData? icono;
  final TextEditingController? controlador;
  final String? error;
  final bool esContrasena;
  final TextInputType tipoTeclado;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiqueta,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controlador,
          keyboardType: tipoTeclado,
          textInputAction: textInputAction,
          obscureText: esContrasena,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icono == null ? null : Icon(icono),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.65),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.purple, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            errorText: error,
          ),
        ),
      ],
    );
  }
}

class BotonPrincipal extends StatelessWidget {
  const BotonPrincipal({
    super.key,
    required this.texto,
    this.onPressed,
    this.habilitado = true,
  });

  final String texto;
  final VoidCallback? onPressed;
  final bool habilitado;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: habilitado ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.purple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          disabledBackgroundColor: Colors.grey.shade300,
        ),
        child: Text(
          texto,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class BotonSecundario extends StatelessWidget {
  const BotonSecundario({
    super.key,
    required this.texto,
    this.icono,
    required this.onPressed,
  });

  final String texto;
  final IconData? icono;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icono == null ? const SizedBox.shrink() : Icon(icono),
      label: Text(texto),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black87,
        side: BorderSide(color: Colors.grey.shade300),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class CasillaCodigo extends StatelessWidget {
  const CasillaCodigo({
    super.key,
    required this.controlador,
    required this.foco,
    this.onChanged,
  });

  final TextEditingController controlador;
  final FocusNode foco;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 60,
      child: TextField(
        controller: controlador,
        focusNode: foco,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.purple, width: 1.5),
          ),
        ),
      ),
    );
  }
}
