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
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Ambil Foto dari Kamera"),
                onTap: () async {
                  final img.XFile? picked = await picker.pickImage(source: img.ImageSource.camera);
                  if (picked != null) setState(() => ktpImage = File(picked.path));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Pilih dari Galeri"),
                onTap: () async {
                  final img.XFile? picked = await picker.pickImage(source: img.ImageSource.gallery);
                  if (picked != null) setState(() => ktpImage = File(picked.path));
                  Navigator.pop(context);
                },
              ),
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

                  // 🔹 Tambahan baru
                  DropdownField(
                    label: "Nama Kepala Keluarga",
                    icon: Icons.family_restroom_sharp,
                    value: vars.namaKepala?.isEmpty ?? true ? null : vars.namaKepala,
                    items: const ["Radit", "Aldi"],
                    onChanged: (v) => setState(() => vars.namaKepala = v),
                  ),

                  ModernTextField(controller: vars.usernameC, label: "Username",prefixIcon: Icons.person, ),
                  ModernTextField(controller: vars.namaC, label: "Nama Lengkap", prefixIcon: Icons.badge),
                  ModernTextField(controller: vars.nikC, label: "NIK", keyboardType: TextInputType.number, prefixIcon: Icons.badge),
                  ModernTextField(controller: vars.telpC, label: "Nomor Telepon (+62)", keyboardType: TextInputType.phone, prefixIcon: Icons.phone),
                  ModernTextField(controller: vars.tempatLahirC, label: "Tempat Lahir", prefixIcon: Icons.location_city),
                  DatePickerField(
                    label: "Tanggal Lahir",
                    icon: Icons.calendar_today,
                    selected: vars.tglLahir,
                    onSelected: (date) => setState(() => vars.tglLahir = date),
                  ),

                  DropdownField(
                    label: "Jenis Kelamin",
                    icon: Icons.male,
                    value: vars.jk,
                    items: const ["Laki-laki", "Perempuan"],
                    onChanged: (v) => setState(() => vars.jk = v),
                  ),

                  DropdownField(
                    label: "Agama",
                    icon: Icons.book,
                    value: vars.agama,
                    items: const [
                      "Islam", "Kristen", "Katolik", "Hindu",
                      "Buddha", "Konghucu", "Lainnya"
                    ],
                    onChanged: (v) => setState(() => vars.agama = v),
                  ),

                  DropdownField(
                    label: "Golongan Darah",
                    icon: Icons.bloodtype,
                    value: vars.goldar,
                    items: const ["A", "B", "AB", "O"],
                    onChanged: (v) => setState(() => vars.goldar = v),
                  ),

                  DropdownField(
                    label: "Peran Keluarga",
                    icon: Icons.family_restroom,
                    value: vars.peran,
                    items: const ["Kepala Keluarga", "Istri", "Anak"],
                    onChanged: (v) => setState(() => vars.peran = v),
                  ),

                  DropdownField(
                    label: "Pendidikan Terakhir",
                    icon: Icons.school,
                    value: vars.pendidikan,
                    items: const [
                      "SD", "SMP", "SMA/SMK",
                      "Diploma", "Sarjana", "Magister", "Doktor"
                    ],
                    onChanged: (v) => setState(() => vars.pendidikan = v),
                  ),

                  DropdownField(
                    label: "Pekerjaan",
                    icon: Icons.work,
                    value: vars.pekerjaan,
                    items: const [
                      "Pelajar", "Mahasiswa", "Wiraswasta", "Pegawai Swasta",
                      "PNS", "IRT", "Tidak Bekerja", "Lainnya"
                    ],
                    onChanged: (v) => setState(() => vars.pekerjaan = v),
                  ),

                  DropdownField(
                    label: "Status Kependudukan",
                    icon: Icons.assignment_ind,
                    value: vars.statusKependudukan,
                    items: const [
                      "Penduduk Tetap",
                      "Pendatang / Tidak Tetap",
                      "Domisili",
                      "Pindah",
                      "Meninggal"
                    ],
                    onChanged: (v) => setState(() => vars.statusKependudukan = v),
                  ),

                  ModernTextField(
                    controller: vars.emailC,
                    label: "Email (harus @gmail)",
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),

                  // **************** FOTO KTP CARD MODERN ****************
                  Text(
                    "Upload Foto KTP/KIA",
                    style: TextStyle(color: Colors.grey[700], fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

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
                      child: ktpImage == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload_file, size: 40, color: Colors.cyan[700]),
                                const SizedBox(height: 10),
                                Text(
                                  "Upload Foto KTP/KIA",
                                  style: TextStyle(color: Colors.cyan[700]),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(ktpImage!, fit: BoxFit.cover),
                            ),
                    ),
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
