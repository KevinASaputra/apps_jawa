import 'package:flutter/material.dart';

class EditKeluargaPage extends StatefulWidget {
  final String name;
  final String kk;
  final String address;
  final String rt;

  const EditKeluargaPage({
    super.key,
    required this.name,
    required this.kk,
    required this.address,
    required this.rt,
  });

  @override
  State<EditKeluargaPage> createState() => _EditKeluargaPageState();
}

class _EditKeluargaPageState extends State<EditKeluargaPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _kkController;
  late TextEditingController _nameController;
  late TextEditingController _nikController;
  late TextEditingController _addressController;
  late String selectedRt;

  @override
  void initState() {
    super.initState();
    _kkController = TextEditingController(text: widget.kk);
    _nameController = TextEditingController(text: widget.name);
    _nikController = TextEditingController(text: "3201012408900001");
    _addressController = TextEditingController(text: widget.address);
    selectedRt = widget.rt;
  }

  @override
  void dispose() {
    _kkController.dispose();
    _nameController.dispose();
    _nikController.dispose();
    _addressController.dispose();
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
        title: const Text("Edit Data Keluarga"),
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
                controller: _kkController,
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "Nama Kepala Keluarga",
                controller: _nameController,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: "NIK Kepala Keluarga",
                controller: _nikController,
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
                controller: _addressController,
                icon: Icons.home_outlined,
                maxLines: 3,
              ),

              const SizedBox(height: 30),

              // =====================================================
              // DATA PRIBADI
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
                value: "Laki-laki",
                items: ["Laki-laki", "Perempuan"],
                icon: Icons.wc_outlined,
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
              const SizedBox(height: 16),

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
            "Hapus Data Keluarga",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Apakah Anda yakin ingin menghapus data keluarga ini? Tindakan ini tidak dapat dibatalkan.",
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
