import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'http_client_mock.mocks.dart'; 

void main() {
  group('Register Warga Unit Test', () {
    late MockClient client;

    setUp(() {
      client = MockClient();
    });

    test('Register API call success', () async {
      final body = {
        'nama': 'John Doe',
        'email': 'john@gmail.com',
        'password': '123456'
      };

      // Mock response
      when(client.post(
        Uri.parse('https://apps-jawa-backend.vercel.app/auth/register'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
        (_) async => http.Response(jsonEncode({'message': 'success'}), 201),
      );

      final response = await client.post(
        Uri.parse('https://apps-jawa-backend.vercel.app/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      expect(response.statusCode, 201);
      final data = jsonDecode(response.body);
      expect(data['message'], 'success');
    });
  });
}
