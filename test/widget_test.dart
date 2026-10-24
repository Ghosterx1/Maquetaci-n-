import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('La app carga la pantalla de login', (tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
    expect(find.text('Inicia sesión para continuar'), findsOneWidget);
  });
}
