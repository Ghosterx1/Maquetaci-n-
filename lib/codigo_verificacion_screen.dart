import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_routes.dart';
import 'package:flutter_application_1/core/widgets/widgets.dart';

class CodigoVerificacionScreen extends StatefulWidget {
  const CodigoVerificacionScreen({super.key, required this.correo});

  final String correo;

  @override
  State<CodigoVerificacionScreen> createState() =>
      _CodigoVerificacionScreenState();
}

class _CodigoVerificacionScreenState extends State<CodigoVerificacionScreen> {
  static const int _totalDigitos = 4;
  static const int _segundosInicio = 45;

  final List<TextEditingController> _casillas =
      List.generate(_totalDigitos, (_) => TextEditingController());
  final List<FocusNode> _focos =
      List.generate(_totalDigitos, (_) => FocusNode());

  Timer? _temporizador;
  int _segundos = _segundosInicio;

  @override
  void initState() {
    super.initState();
    _iniciarContador();
  }

  @override
  void dispose() {
    _temporizador?.cancel();
    for (final c in _casillas) {
      c.dispose();
    }
    for (final f in _focos) {
      f.dispose();
    }
    super.dispose();
  }

  // ── Lógica del contador ──────────────────────────────────────────────────

  void _iniciarContador() {
    _temporizador?.cancel();
    setState(() => _segundos = _segundosInicio);
    _temporizador = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_segundos <= 1) {
        timer.cancel();
        setState(() => _segundos = 0);
      } else {
        setState(() => _segundos--);
      }
    });
  }

  String get _tiempoFormateado =>
      '00:${_segundos.toString().padLeft(2, '0')}';

  // ── Lógica de casillas ───────────────────────────────────────────────────

  String get _codigoIngresado =>
      _casillas.map((c) => c.text).join();

  void _onCasillaChanged(int indice, String valor) {
    if (valor.isNotEmpty && indice < _totalDigitos - 1) {
      _focos[indice + 1].requestFocus();
    } else if (valor.isEmpty && indice > 0) {
      _focos[indice - 1].requestFocus();
    }
    setState(() {});
  }

  // ── Navegación ───────────────────────────────────────────────────────────

  void _siguiente() {
    if (_codigoIngresado.length != _totalDigitos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa el código de 4 dígitos')),
      );
      return;
    }
    Navigator.pushNamed(context, AppRoutes.nuevaContrasena);
  }

  @override
  Widget build(BuildContext context) {
    return FondoDecorativo(
      esquema: EsquemaFondo.rosaCalido,
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

              // ── Ícono de pantalla ────────────────────────────────────────
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: AppColors.warmGradient,
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Verifica tu correo',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Escribe el código de 4 dígitos que enviamos a ${widget.correo}',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),

              // ── 4 casillas ───────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  _totalDigitos,
                  (i) => CasillaCodigo(
                    controlador: _casillas[i],
                    foco: _focos[i],
                    onChanged: (v) => _onCasillaChanged(i, v),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── Reenviar / contador ──────────────────────────────────────
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    '¿No te llegó? ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  if (_segundos == 0)
                    TextButton(
                      onPressed: _iniciarContador,
                      child: const Text(
                        'Reenviar código',
                        style: TextStyle(
                          color: AppColors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    Text(
                      'Reenviar código en $_tiempoFormateado',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),

              BotonPrincipal(
                texto: 'Siguiente',
                habilitado: _codigoIngresado.length == _totalDigitos,
                onPressed: _siguiente,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
