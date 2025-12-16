import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

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

          // footer - copyright
          Positioned(bottom: 20, left: 0, right: 0, child: _buildFooter()),
        ],
      ),
    );
  }

  // komponen UI
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
      child: Image.asset('assets/icon/app.png', fit: BoxFit.contain),
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
        const Text("Username"),
        const SizedBox(height: 6),
        _buildTextField(hint: "Masukkan username", icon: Icons.person_outline),
        const SizedBox(height: 20),

        const Text("Password"),
        const SizedBox(height: 6),
        _buildPasswordField(),

        const SizedBox(height: 20),
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildTextField({required String hint, required IconData icon}) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
      ),
    );
  }

  /// LOGIN BUTTON
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
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.dashboardWarga);
        },
        child: const Text(
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
        // lupa password
        TextButton(onPressed: () {}, child: const Text("Lupa password?")),

        // buat akun (masih 1 line tapi kanan)
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

  // footer - copyright
  Widget _buildFooter() {
    return const Text(
      "© 2025 Jawara Pintar. All rights reserved.",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12, color: Colors.black54),
    );
  }
}
