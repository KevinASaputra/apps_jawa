import 'package:flutter/material.dart';

class TambahWargaPage extends StatefulWidget {
  const TambahWargaPage({super.key});

  @override
  State<TambahWargaPage> createState() => _TambahWargaPageState();
}

class _TambahWargaPageState extends State<TambahWargaPage> {
  final _formKey = GlobalKey<FormState>();
  String selectedRt = "RT 01";
  String selectedAgama = "Islam";
  String selectedPendidikan = "SD";
  String selectedStatusKawin = "Belum Kawin";
  String selectedGender = "Laki-laki";
  String selectedHubungan = "Kepala Keluarga";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Tambah Data Warga"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================================
              // INFORMASI DASAR
              // =====================================================
              const Text(
                "Informasi Dasar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: "NIK",
                hint: "Masukkan NIK",
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Nama Lengkap",
                hint: "Masukkan nama lengkap",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "No. Kartu Keluarga (KK)",
                hint: "Masukkan No. KK",
                icon: Icons.badge_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              _buildDropdownField(
                label: "Hubungan dalam Keluarga",
                value: selectedHubungan,
                items: ["Kepala Keluarga", "Istri", "Anak", "Menantu", "Cucu", "Orang Tua", "Lainnya"],
                icon: Icons.family_restroom_outlined,
                onChanged: (value) {
                  setState(() {
                    selectedHubungan = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // RT Selection
              _buildDropdownField(
                label: "RT",
                value: selectedRt,
                items: ["RT 01", "RT 02", "RT 03", "RT 04"],
                icon: Icons.location_city_outlined,
                onChanged: (value) {
                  setState(() {
                    selectedRt = value!;
                  });
                },
              ),

              const SizedBox(height: 30),

              // =====================================================
              // DATA PRIBADI
              // =====================================================
              const Text(
                "Data Pribadi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: "Tempat Lahir",
                hint: "Masukkan tempat lahir",
                icon: Icons.place_outlined,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Tanggal Lahir",
                hint: "DD/MM/YYYY",
                icon: Icons.calendar_today_outlined,
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 16),

              _buildDropdownField(
                label: "Jenis Kelamin",
                value: selectedGender,
                items: ["Laki-laki", "Perempuan"],
                icon: Icons.wc_outlined,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildDropdownField(
                label: "Golongan Darah",
                value: "O",
                items: ["A", "B", "AB", "O", "Tidak Tahu"],
                icon: Icons.bloodtype_outlined,
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),

              _buildDropdownField(
                label: "Agama",
                value: selectedAgama,
                items: ["Islam", "Kristen", "Katolik", "Hindu", "Buddha", "Konghucu"],
                icon: Icons.church_outlined,
                onChanged: (value) {
                  setState(() {
                    selectedAgama = value!;
                  });
                },
              ),

              const SizedBox(height: 30),

              // =====================================================
              // PENDIDIKAN & PEKERJAAN
              // =====================================================
              const Text(
                "Pendidikan & Pekerjaan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              _buildDropdownField(
                label: "Pendidikan Terakhir",
                value: selectedPendidikan,
                items: ["Tidak Sekolah", "SD", "SMP", "SMA", "D3", "S1", "S2", "S3"],
                icon: Icons.school_outlined,
                onChanged: (value) {
                  setState(() {
                    selectedPendidikan = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Pekerjaan",
                hint: "Masukkan pekerjaan",
                icon: Icons.work_outline,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Nama Perusahaan (Opsional)",
                hint: "Masukkan nama perusahaan",
                icon: Icons.business_outlined,
              ),

              const SizedBox(height: 30),

              // =====================================================
              // STATUS & KONTAK
              // =====================================================
              const Text(
                "Status & Kontak",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              _buildDropdownField(
                label: "Status Perkawinan",
                value: selectedStatusKawin,
                items: ["Belum Kawin", "Kawin", "Cerai Hidup", "Cerai Mati"],
                icon: Icons.favorite_outline,
                onChanged: (value) {
                  setState(() {
                    selectedStatusKawin = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "No. Telepon",
                hint: "Masukkan nomor telepon",
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Email (Opsional)",
                hint: "Masukkan email",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 30),

              // =====================================================
              // SUBMIT BUTTON
              // =====================================================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Save data
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF00AFC1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Simpan Data Warga",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: const Color(0xFF00AFC1)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF00AFC1), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field ini wajib diisi';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF00AFC1)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF00AFC1), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
