import 'package:flutter/material.dart';

class AppColors {
  static const Color pink = Color(0xFFEC4899);
  static const Color purple = Color(0xFF7B2FF7);
  static const Color orange = Color(0xFFFFA726);
  static const Color blue = Color(0xFF3B82F6);
  static const Color greenSuccess = Color(0xFF16A34A);
  static const Color greenSuccessBg = Color(0xFFE8F8EE);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [purple, pink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradientDiag = LinearGradient(
    colors: [purple, pink],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warmGradient = LinearGradient(
    colors: [Color(0xFFFEC489), Color(0xFFF472B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
