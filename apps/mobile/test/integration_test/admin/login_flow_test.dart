import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jawara/main.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('E2E Login berhasil', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Input email & password
    await tester.enterText(find.byType(TextField).at(0), 'admin@jawara.app');
    await tester.enterText(find.byType(TextField).at(1), 'admin123');

    await tester.tap(find.text('Masuk'));

    // Tunggu semua UI selesai
    await tester.pumpAndSettle();

    // Verifikasi widget welcome muncul
    expect(find.byKey(const Key('admin_welcome_text')), findsOneWidget);
  });
}
