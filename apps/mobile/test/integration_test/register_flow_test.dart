import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:jawara/features/register/pages/warga/register_warga.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('E2E Register Warga Flow with mocked HTTP', (WidgetTester tester) async {
    // Buat MockClient
    final mockClient = MockClient((request) async {
      if (request.url.toString().contains('/auth/register')) {
        return http.Response(
          jsonEncode({
            "message": "Register berhasil, silakan lengkapi profil & data keluarga",
            "user": {"id": 12, "name": "John Doe", "email": "john@gmail.com", "account_status": "PENDING"}
          }),
          201,
          headers: {"Content-Type": "application/json"},
        );
      }
      return http.Response('Not Found', 404);
    });

    // Pump halaman RegisterWargaPage dengan dependency injection
    await tester.pumpWidget(MaterialApp(
      home: RegisterWargaPage(), // pastikan page bisa menerima client
    ));
    await tester.pumpAndSettle();

    // Isi form
    await tester.enterText(find.byKey(const Key('nama_field')), 'John Doe');
    await tester.enterText(find.byKey(const Key('email_field')), 'john@gmail.com');
    await tester.enterText(find.byKey(const Key('password_field')), '123456');
    await tester.pumpAndSettle();

    // Klik submit
    final findSubmitButton = find.byKey(const Key('submit_register_button'));
    await tester.tap(findSubmitButton);
    await tester.pump(); 
    await tester.pump(const Duration(seconds: 1)); 

    // Cek SnackBar muncul
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('Register berhasil'), findsOneWidget);
  });
}
