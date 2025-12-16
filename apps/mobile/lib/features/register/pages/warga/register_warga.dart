import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../../models/text_field.dart';
import '../../controller/controller_warga.dart';
import '../../../../services/api_client.dart';
import '../../../../routes/app_routes.dart';

class RegisterWargaPage extends StatefulWidget {
  const RegisterWargaPage({super.key});

  @override
  State<RegisterWargaPage> createState() => _RegisterWargaPageState();
}

class _RegisterWargaPageState extends State<RegisterWargaPage> {
  final vars = RegisterWargaVariables();
  File? ktpImage;
  bool _isLoading = false;

  Future<void> _handleRegister() async {
    // Validate inputs
    if (vars.namaC.text.trim().isEmpty) {
      _showError('Nama tidak boleh kosong');
      return;
    }

    if (vars.emailC.text.trim().isEmpty || !vars.emailC.text.contains('@')) {
      _showError('Email tidak valid');
      return;
    }

    if (vars.passwordC.text.length < 6) {
      _showError('Password minimal 6 karakter');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Using Dio directly with JSON
      final response = await ApiClient().dio.post(
        '/auth/register',
        data: {
          'name': vars.namaC.text.trim(),
          'email': vars.emailC.text.trim(),
          'password': vars.passwordC.text,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registrasi berhasil! Silakan login.'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to login page
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
      }
    } catch (e) {
      if (!mounted) return;
      _showError('Registrasi gagal: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return SizedBox(
          height: 160,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 5,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan[700],
        title: const Text("Register Warga"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // **************** CARD FORM ****************
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModernTextField(
                    controller: vars.namaC,
                    label: "Nama Lengkap",
                    prefixIcon: Icons.badge,
                  ),
                  ModernTextField(
                    controller: vars.emailC,
                    label: "Email (harus @gmail)",
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  ModernTextField(
                    controller: vars.passwordC,
                    label: "Password",
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // **************** BUTTON SAVE ****************
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 3,
                ),
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
                        "Simpan Data",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
