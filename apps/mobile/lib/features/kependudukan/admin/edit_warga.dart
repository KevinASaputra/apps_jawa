import 'package:flutter/material.dart';

class EditWargaPage extends StatefulWidget {
  final String name;
  final String nik;
  final String gender;
  final String age;
  final String rt;

  const EditWargaPage({
    super.key,
    required this.name,
    required this.nik,
    required this.gender,
    required this.age,
    required this.rt,
  });

  @override
  State<EditWargaPage> createState() => _EditWargaPageState();
}

class _EditWargaPageState extends State<EditWargaPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nikController;
  late TextEditingController _nameController;
  late TextEditingController _kkController;
  late String selectedRt;
  late String selectedGender;

  @override
  void initState() {
    super.initState();
    _nikController = TextEditingController(text: widget.nik);
    _nameController = TextEditingController(text: widget.name);
    _kkController = TextEditingController(text: "3201012408900001");
    selectedRt = widget.rt;
    selectedGender = widget.gender;
  }

  @override
  void dispose() {
    _nikController.dispose();
    _nameController.dispose();
    _kkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Edit Data Warga"),
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
                controller: _nikController,
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Nama Lengkap",
                controller: _nameController,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "No. Kartu Keluarga (KK)",
                controller: _kkController,
                icon: Icons.badge_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              _buildDropdownField(
                label: "Hubungan dalam Keluarga",
                value: "Kepala Keluarga",
                items: ["Kepala Keluarga", "Istri", "Anak", "Menantu", "Cucu", "Orang Tua", "Lainnya"],
                icon: Icons.family_restroom_outlined,
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),

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
                controller: TextEditingController(text: "Jakarta"),
                icon: Icons.place_outlined,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Tanggal Lahir",
                controller: TextEditingController(text: "24/08/1990"),
                icon: Icons.calendar_today_outlined,
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
                value: "Islam",
                items: ["Islam", "Kristen", "Katolik", "Hindu", "Buddha", "Konghucu"],
                icon: Icons.church_outlined,
                onChanged: (value) {},
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
                value: "S1",
                items: ["Tidak Sekolah", "SD", "SMP", "SMA", "D3", "S1", "S2", "S3"],
                icon: Icons.school_outlined,
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Pekerjaan",
                controller: TextEditingController(text: "Pegawai Swasta"),
                icon: Icons.work_outline,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Nama Perusahaan",
                controller: TextEditingController(text: "PT. Maju Jaya"),
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
                value: "Kawin",
                items: ["Belum Kawin", "Kawin", "Cerai Hidup", "Cerai Mati"],
                icon: Icons.favorite_outline,
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "No. Telepon",
                controller: TextEditingController(text: "0812-3456-7890"),
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Email",
                controller: TextEditingController(text: "budi.santoso@email.com"),
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
                      // TODO: Update data
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
                    "Simpan Perubahan",
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
    required TextEditingController controller,
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
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
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

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Hapus Data Warga",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Apakah Anda yakin ingin menghapus data warga ini? Tindakan ini tidak dapat dibatalkan.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Batal",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Delete data
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close edit page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Hapus", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
