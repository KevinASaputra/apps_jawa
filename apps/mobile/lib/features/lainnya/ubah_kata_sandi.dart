import 'package:flutter/material.dart';
import '../../models/text_field.dart';

class UbahKataSandiPage extends StatefulWidget {
  const UbahKataSandiPage({super.key});

  @override
  State<UbahKataSandiPage> createState() => _UbahKataSandiPageState();
}

class _UbahKataSandiPageState extends State<UbahKataSandiPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Ubah Kata Sandi"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Keamanan Akun",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Pastikan kata sandi baru Anda kuat dan mudah diingat",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              "Kata Sandi Lama",
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            ModernTextField(
              controller: _oldPasswordController,
              label: "Masukkan kata sandi lama",
              obscure: _obscureOld,
              suffix: IconButton(
                icon: Icon(
                  _obscureOld ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  setState(() {
                    _obscureOld = !_obscureOld;
                  });
                },
              ),
            ),

            const Text(
              "Kata Sandi Baru",
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            ModernTextField(
              controller: _newPasswordController,
              label: "Masukkan kata sandi baru",
              obscure: _obscureNew,
              suffix: IconButton(
                icon: Icon(
                  _obscureNew ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  setState(() {
                    _obscureNew = !_obscureNew;
                  });
                },
              ),
            ),

            const Text(
              "Konfirmasi Kata Sandi Baru",
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            ModernTextField(
              controller: _confirmPasswordController,
              label: "Konfirmasi kata sandi baru",
              obscure: _obscureConfirm,
              suffix: IconButton(
                icon: Icon(
                  _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirm = !_obscureConfirm;
                  });
                },
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Validate and change password
                  if (_newPasswordController.text !=
                      _confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Kata sandi baru tidak cocok"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Kata sandi berhasil diubah"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
