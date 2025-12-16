import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../routes/app_routes.dart';
import '../services/api_client.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Using Dio directly with JSON
      final response = await ApiClient().dio.post(
        '/auth/login',
        data: {
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        if (data == null) {
          throw Exception('Invalid response from server');
        }

        // Save authentication data
        await AuthService().saveAuth(
          token: data['token'] ?? '',
          userId: data['user']?['id'] ?? 0,
          name: data['user']?['name'] ?? '',
          email: data['user']?['email'] ?? '',
          role: data['user']?['role'] ?? 'Buyer',
        );

        if (!mounted) return;

        // Navigate based on role
        final role = data['user']?['role'] ?? 'Buyer';
        if (role == 'Admin' || role == 'RT' || role == 'RW') {
          Navigator.pushReplacementNamed(context, AppRoutes.dashboardAdmin);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.dashboardWarga);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login berhasil!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      String errorMessage = 'Login gagal';

      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.unknown) {
          errorMessage =
              '⚠️ Tidak dapat terhubung ke server.\n\nCatatan: Flutter Web memiliki limitasi CORS.\nSilakan gunakan:\n• Flutter Mobile (Android/iOS)\n• Flutter Desktop (macOS/Windows)\n\nAtau aktifkan CORS di backend.';
        } else if (e.response?.statusCode == 401) {
          errorMessage = 'Email atau password salah';
        } else if (e.response != null) {
          errorMessage = e.response?.data['message'] ?? 'Login gagal';
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

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
                    const SizedBox(height: 24),
                    // CORS Warning Banner for Web
                    if (Theme.of(context).platform == TargetPlatform.windows ||
                        Theme.of(context).platform == TargetPlatform.linux ||
                        Theme.of(context).platform == TargetPlatform.macOS)
                      _buildWebWarningBanner(),
                    const SizedBox(height: 16),
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

  Widget _buildWebWarningBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade300),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange.shade700,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Web version has CORS limitations. Please use mobile or desktop app for full functionality.',
              style: TextStyle(fontSize: 12, color: Colors.orange.shade900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Email"),
          const SizedBox(height: 6),
          _buildEmailField(),
          const SizedBox(height: 20),

          const Text("Password"),
          const SizedBox(height: 6),
          _buildPasswordField(),

          const SizedBox(height: 20),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        hintText: "Masukkan email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        if (!value.contains('@')) {
          return 'Email tidak valid';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        if (value.length < 6) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
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
        onPressed: _isLoading ? null : _handleLogin,
        child: _isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
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
