import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aprende_jugando/main.dart';
import 'package:aprende_jugando/screens/welcome_screen.dart';

void main() {
  testWidgets('muestra la pantalla de bienvenida', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const WelcomeScreen(),
        theme: ThemeData.dark(),
      ),
    );

    expect(find.textContaining('aprendizaje'), findsOneWidget);
    expect(find.text('Comenzar la aventura'), findsOneWidget);
  });

  testWidgets('la app arranca en splash', (WidgetTester tester) async {
    await tester.pumpWidget(const AprendeJugandoApp());
    expect(find.text('Aprende Jugando'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 2300));
    await tester.pumpAndSettle();
    expect(find.text('Comenzar la aventura'), findsOneWidget);
  });
}
