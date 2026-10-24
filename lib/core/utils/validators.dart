class Validators {
  static String? requerido(String? value, [String nombreCampo = 'Campo']) {
    if (value == null || value.trim().isEmpty) {
      return 'El campo $nombreCampo es obligatorio';
    }
    return null;
  }

  static String? correo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa tu correo electrónico';
    }

    final email = value.trim();
    final regex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    if (!regex.hasMatch(email)) {
      return 'Ingresa un correo válido';
    }

    return null;
  }

  static String? contrasenaBasica(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa una contraseña';
    }

    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }

    return null;
  }

  static String? confirmarContrasena(String? confirmar, String? original) {
    if (confirmar == null || confirmar.trim().isEmpty) {
      return 'Confirma tu contraseña';
    }

    if (confirmar != original) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }
}
