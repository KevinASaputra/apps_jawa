import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../models/text_field.dart';
import '../../controller/controller_warga.dart';

class RegisterWargaPage extends StatefulWidget {
  const RegisterWargaPage({super.key});

  @override
  State<RegisterWargaPage> createState() => _RegisterWargaPageState();
}

class _RegisterWargaPageState extends State<RegisterWargaPage> {
  final vars = RegisterWargaVariables();
  bool isLoading = false;

  Future<void> submitRegister() async {
    // Validasi form
    if (vars.namaC.text.isEmpty ||
        vars.emailC.text.isEmpty ||
        vars.passwordC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap isi semua field")),
      );
      return;
    }

    if (!vars.emailC.text.endsWith('@gmail.com')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email harus berakhiran @gmail.com")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final url = "https://apps-jawa-backend.vercel.app/auth/register";
      final body = {
        "name": vars.namaC.text.trim(),
        "email": vars.emailC.text.trim(),
        "password": vars.passwordC.text.trim(),
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(body),
      );

      print(response.statusCode);
      print(response.body);

      final respData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Gunakan pesan dari backend dan beri key supaya integration test bisa menemukan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            key: const Key('snackbar_register_success'),
            content: Text(respData['message'] ?? "Register berhasil!"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(respData['message'] ?? response.statusCode.toString()),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
            // ================= CARD FORM =================
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
                    key: const Key('nama_field'),
                    label: "Nama Lengkap",
                    prefixIcon: Icons.badge,
                  ),
                  ModernTextField(
                    controller: vars.emailC,
                    key: const Key('email_field'),
                    label: "Email (harus @gmail)",
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  ModernTextField(
                    controller: vars.passwordC,
                    key: const Key('password_field'),
                    label: "Password",
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // ================= BUTTON SAVE =================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                key: const Key('submit_register_button'),
                onPressed: isLoading ? null : submitRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 3,
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
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
