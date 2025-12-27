import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jawara/services/login_service.dart';

import 'login_page_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('LoginService Unit Test', () {
    late MockClient client;
    late LoginService service;

    setUp(() {
      client = MockClient();
      service = LoginService(client: client);
    });

    test('Throw error jika email dan password kosong', () async {
      expect(
        () async => await service.login('', ''),
        throwsA(predicate(
            (e) => e.toString().contains("Email dan password wajib diisi"))),
      );
    });

    test('Login berhasil untuk Admin', () async {
      final mockResponse = http.Response(
        jsonEncode({
          "message": "Login berhasil",
          "token": "fake-token",
          "user": {
            "id": 4,
            "name": "Super Admin",
            "email": "admin@jawara.app",
            "role": "Admin"
          }
        }),
        200,
      );

      when(
        client.post(
          Uri.parse('https://apps-jawa-backend.vercel.app/auth/login'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => mockResponse);

      final result =
          await service.login('admin@jawara.app', 'admin123');

      expect(result['token'], 'fake-token');
      expect(result['user']['role'], 'Admin');
    });

    test('Login gagal password salah', () async {
      final mockResponse = http.Response(
        jsonEncode({"message": "Email atau password salah"}),
        401,
      );

      when(
        client.post(
          Uri.parse('https://apps-jawa-backend.vercel.app/auth/login'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => mockResponse);

      expect(
        () async =>
            await service.login('wrong@example.com', 'wrongpass'),
        throwsA(predicate(
            (e) => e.toString().contains("Email atau password salah"))),
      );
    });
  });
}
