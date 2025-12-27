import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final http.Client client;

  LoginService({required this.client});

  Future<Map<String, dynamic>> login(String email, String password) async {
    if(email.isEmpty || password.isEmpty) {
      throw Exception("Email dan password wajib diisi");
    }

    final response = await client.post(
      Uri.parse('https://apps-jawa-backend.vercel.app/auth/login'),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);

    if(response.statusCode != 200) {
      throw Exception(data['message'] ?? "Login gagal");
    }

    return data;
  }
}
