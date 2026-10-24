class PasswordRequirement {
  const PasswordRequirement({
    required this.label,
    required this.isMet,
  });

  final String label;
  final bool Function(String) isMet;
}

final List<PasswordRequirement> passwordRequirements = [
  PasswordRequirement(
    label: 'Al menos 8 caracteres',
    isMet: (value) => value.length >= 8,
  ),
  PasswordRequirement(
    label: 'Una mayúscula',
    isMet: (value) => value.contains(RegExp(r'[A-Z]')),
  ),
  PasswordRequirement(
    label: 'Una minúscula',
    isMet: (value) => value.contains(RegExp(r'[a-z]')),
  ),
  PasswordRequirement(
    label: 'Un número',
    isMet: (value) => value.contains(RegExp(r'[0-9]')),
  ),
  PasswordRequirement(
    label: 'Un carácter especial',
    isMet: (value) => value.contains(RegExp(r'[^A-Za-z0-9]')),
  ),
];
