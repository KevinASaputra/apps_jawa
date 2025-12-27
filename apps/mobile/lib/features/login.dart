import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../routes/app_routes.dart';

// ==========================
// SSL Override untuk testing
// ==========================
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Override SSL (hanya testing)
    HttpOverrides.global = MyHttpOverrides();
  }

  // =========================
  // LOGIN FUNCTION
  // =========================
  Future<void> login() async {
  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    _showError("Email dan password wajib diisi");
    return;
  }

  setState(() => _isLoading = true);

  try {
    final response = await http
        .post(
          Uri.parse('https://apps-jawa-backend.vercel.app/auth/login'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            "email": emailController.text.trim(),
            "password": passwordController.text,
          }),
        )
        .timeout(const Duration(seconds: 40));

    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("RAW BODY: ${response.body}");

    Map<String, dynamic> data;
    try {
      data = jsonDecode(response.body);
    } catch (e) {
      _showError("Response bukan JSON valid");
      debugPrint("JSON DECODE ERROR: $e");
      return;
    }

    if (response.statusCode == 200) {
      // Login berhasil → ambil token & user
      final token = data['token'] ?? '';
      final user = data['user'] ?? {};
      final role = user['role'] ?? '';

      debugPrint("TOKEN: $token");
      debugPrint("ROLE: $role");

      // Navigasi sesuai role
      if (role == 'Admin') {
        Navigator.pushReplacementNamed(context, AppRoutes.dashboardAdmin);
      } else if (role == 'Seller' || role == 'Buyer') {
        Navigator.pushReplacementNamed(context, AppRoutes.dashboardWarga);
      } else {
        _showError("Role tidak dikenali");
      }
    } else {
      // Login gagal → tampilkan message API
      final message = data['message'];
      _showError(message);
    }
  } on TimeoutException {
    _showError("Server tidak merespons");
  } on SocketException {
    _showError("Tidak ada koneksi internet");
  } catch (e, stacktrace) {
    debugPrint("ERROR TYPE: ${e.runtimeType}");
    debugPrint("ERROR: $e");
    debugPrint("STACKTRACE: $stacktrace");
    _showError("Terjadi kesalahan saat login");
  } finally {
    setState(() => _isLoading = false);
  }
}

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // =========================
  // UI
  // =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 32),
                    _buildTitle(),
                    const SizedBox(height: 40),
                    _buildForm(),
                    const SizedBox(height: 10),
                    _buildActionsRow(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          Positioned(bottom: 20, left: 0, right: 0, child: _buildFooter()),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE0FFFF), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00AFC1).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Image.asset('assets/icon/app.png'),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: const [
        Text(
          "JAWARA",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00AFC1),
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Jawa Warga Pintar",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Email"),
        const SizedBox(height: 6),
        TextField(
          key: const Key('emailField'),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email_outlined),
            hintText: "Masukkan email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
          ),
        ),

        const SizedBox(height: 20),
        const Text("Password"),
        const SizedBox(height: 6),
        TextField(
          key: const Key('passwordField'),
          controller: passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
              child: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            hintText: "Masukkan password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
          ),
        ),
        const SizedBox(height: 24),
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        onPressed: _isLoading ? null : login,
        key: const Key('loginButton'),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Masuk",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildActionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: () {}, child: const Text("Lupa password?")),
        RichText(
          text: TextSpan(
            text: "Belum punya akun? ",
            style: const TextStyle(color: Colors.black87, fontSize: 14),
            children: [
              TextSpan(
                text: "Buat",
                style: TextStyle(
                  color: Colors.cyan.shade700,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, AppRoutes.registerChoice);
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return const Text(
      "© 2025 Jawara Pintar. All rights reserved.",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12, color: Colors.black54),
    );
  }
}
