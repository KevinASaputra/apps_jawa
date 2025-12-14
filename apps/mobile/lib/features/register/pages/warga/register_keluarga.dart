import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as img;
import '../../../../models/text_field.dart';
import '../../../../models/dropdown_field.dart';
import '../../../../models/date_picker_field.dart';
import '../../controller/controller_warga.dart';
import '../../controller/controller_keluarga.dart';

class RegisterKeluargaPage extends StatefulWidget {
  const RegisterKeluargaPage({super.key});

  @override
  State<RegisterKeluargaPage> createState() => _RegisterKeluargaPageState();
}

class _RegisterKeluargaPageState extends State<RegisterKeluargaPage> {
  final vars = RegisterWargaVariables();
  final keluargaCtrl = KeluargaController();
  final List<RegisterWargaVariables> anggota = [];

  @override
  void initState() {
    super.initState();
    keluargaController();
  }

  keluargaController() {
    addAnggota(); // mulai dengan 1 anggota
  }

  void addAnggota() {
    anggota.add(RegisterWargaVariables());
    setState(() {});
  }

  void removeAnggota(int index) {
    if (anggota.length > 1) {
      anggota.removeAt(index);
      setState(() {});
    }
  }

  // ambil foto
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
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Ambil Foto dari Kamera"),
                onTap: () async {
                  final img.XFile? picked = await picker.pickImage(source: img.ImageSource.camera);
                  if (picked != null) setState(() => vars.foto = File(picked.path));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Pilih dari Galeri"),
                onTap: () async {
                  final img.XFile? picked = await picker.pickImage(source: img.ImageSource.gallery);
                  if (picked != null) setState(() => vars.foto = File(picked.path));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // validasi gmail
  bool validGmail(String email) => email.endsWith("@gmail.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Keluarga"),
        backgroundColor: Colors.cyan,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------- FORM KEPALA KELUARGA ----------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(.05),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModernTextField(controller: keluargaCtrl.namaKKC, label: "Nama Kepala Keluarga",prefixIcon: Icons.family_restroom, ),
                  ModernTextField(controller: keluargaCtrl.noKKC, label: "Nomor KK", prefixIcon: Icons.badge),
                  ModernTextField(controller: keluargaCtrl.alamatC, label: "Alamat", keyboardType: TextInputType.number, prefixIcon: Icons.badge),
                  ModernTextField(controller: keluargaCtrl.emailC, label: "Email", keyboardType: TextInputType.emailAddress, prefixIcon: Icons.email),

                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.cyan, width: 1.2),
                        color: Colors.cyan.withOpacity(0.05),
                      ),
                      child: keluargaCtrl.fotoKK == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload_file, size: 40, color: Colors.cyan[700]),
                                const SizedBox(height: 10),
                                Text(
                                  "Upload Foto KK",
                                  style: TextStyle(color: Colors.cyan[700]),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(keluargaCtrl.fotoKK!, fit: BoxFit.cover),
                            ),
                    ),
                  ),
                  
                  
                ],
              ),
            ),
          


            const SizedBox(height: 28),
            const Text("Anggota Keluarga",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // ---------- FORM ANGGOTA ----------
            ...List.generate(anggota.length, (i) {
            final a = anggota[i];

            return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.cyan.shade50,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.cyan.shade200),
              ),
              child: Column(
                children: [
                  // header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Anggota ${i + 1}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      if (anggota.length > 1)
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => removeAnggota(i),
                        ),
                    ],
                  ),


                  ModernTextField(controller: a.namaC, label: "Nama Lengkap", prefixIcon: Icons.badge),
                  
                  ModernTextField(
                    controller: a.emailC,
                    label: "Email (@gmail.com)",
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  ModernTextField(
                    controller: a.passwordC,
                    label: "Password",
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ],
              ),
            );
          }),
          TextButton.icon(
            onPressed: addAnggota,
            icon: const Icon(Icons.add, color: Colors.cyan),
            label: const Text("Tambah Anggota"),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
              ),
              child: const Text("Simpan Data Keluarga", style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (!validGmail(keluargaCtrl.emailC.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Email kepala keluarga harus @gmail.com")),
                  );
                  return;
                }
              },
            ),
          ),
        ],
      ),
    ),
  );
  }
}
