import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as img;
import '../../../../models/text_field.dart';
import '../../../../models/dropdown_field.dart';
import '../../../../models/date_picker_field.dart';
import '../../controller/controller_warga.dart';

class RegisterWargaPage extends StatefulWidget {
  const RegisterWargaPage({super.key});

  @override
  State<RegisterWargaPage> createState() => _RegisterWargaPageState();
}

class _RegisterWargaPageState extends State<RegisterWargaPage> {
  final vars = RegisterWargaVariables();
  File? ktpImage;

  Future<void> pickImage() async {
    final picker = img.ImagePicker();

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
        title: const Text(
          "Register Warga",
        ),
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
                  )
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ModernTextField(controller: vars.namaC, label: "Nama Lengkap", prefixIcon: Icons.badge),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  "Simpan Data",
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
