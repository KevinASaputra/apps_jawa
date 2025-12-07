import 'package:flutter/material.dart';

class TambahKeluargaPage extends StatefulWidget {
  const TambahKeluargaPage({super.key});

  @override
  State<TambahKeluargaPage> createState() => _TambahKeluargaPageState();
}

class _TambahKeluargaPageState extends State<TambahKeluargaPage> {
  final _formKey = GlobalKey<FormState>();
  String selectedRt = "RT 01";
  String selectedAgama = "Islam";
  String selectedPendidikan = "SD";
  String selectedStatusKawin = "Belum Kawin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Tambah Data Keluarga"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================================
              // INFORMASI KEPALA KELUARGA
              // =====================================================
              const Text(
                "Informasi Kepala Keluarga",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              _buildTextField(
                label: "No. Kartu Keluarga (KK)",
                hint: "Masukkan No. KK",
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Nama Kepala Keluarga",
                hint: "Masukkan nama lengkap",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "NIK Kepala Keluarga",
                hint: "Masukkan NIK",
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
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
              const SizedBox(height: 16),

              _buildTextField(
                label: "Alamat Lengkap",
                hint: "Masukkan alamat lengkap",
                icon: Icons.home_outlined,
                maxLines: 3,
              ),

              const SizedBox(height: 30),

              // =====================================================
              // DATA PRIBADI KEPALA KELUARGA
              // =====================================================
              const Text(
                "Data Pribadi Kepala Keluarga",
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
                value: "Laki-laki",
                items: ["Laki-laki", "Perempuan"],
                icon: Icons.wc_outlined,
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
              const SizedBox(height: 16),

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
                label: "Golongan Darah",
                hint: "A/B/AB/O",
                icon: Icons.bloodtype_outlined,
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
                    "Simpan Data Keluarga",
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
