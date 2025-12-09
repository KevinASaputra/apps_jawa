import 'package:flutter/material.dart';
import 'widgets/kependudukan_widgets.dart';
import 'edit_warga.dart';

class DetailWargaPage extends StatelessWidget {
  final String name;
  final String nik;
  final String gender;
  final String age;
  final String rt;

  const DetailWargaPage({
    super.key,
    required this.name,
    required this.nik,
    required this.gender,
    required this.age,
    required this.rt,
  });

  @override
  Widget build(BuildContext context) {
    IconData genderIcon = gender.toLowerCase() == "laki-laki" 
        ? Icons.male_outlined 
        : Icons.female_outlined;
    Color genderColor = gender.toLowerCase() == "laki-laki" 
        ? Colors.blue 
        : Colors.pink;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // =====================================================
          // SLIVER APP BAR
          // =====================================================
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      genderColor,
                      genderColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // AVATAR
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                          ),
                          child: Icon(genderIcon, color: Colors.white, size: 48),
                        ),
                        const SizedBox(height: 16),
                        
                        // NAME
                        Text(
                          name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // RT BADGE
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: Text(
                            rt,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // =====================================================
          // MAIN CONTENT
          // =====================================================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =====================================================
                  // INFORMASI PRIBADI
                  // =====================================================
                  const Text(
                    "Informasi Pribadi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  InfoCard(
                    items: [
                      InfoItem(label: "Nama Lengkap", value: name),
                      InfoItem(label: "NIK", value: nik),
                      InfoItem(label: "Tempat, Tanggal Lahir", value: "Jakarta, 24 Agustus 1990"),
                      InfoItem(label: "Jenis Kelamin", value: gender),
                      InfoItem(label: "Umur", value: age),
                      InfoItem(label: "Golongan Darah", value: "O"),
                      InfoItem(label: "Agama", value: "Islam"),
                      InfoItem(label: "Status Perkawinan", value: "Kawin"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // INFORMASI KELUARGA
                  // =====================================================
                  const Text(
                    "Informasi Keluarga",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  InfoCard(
                    items: [
                      InfoItem(label: "No. KK", value: "3201012408900001"),
                      InfoItem(label: "Kepala Keluarga", value: "Budi Santoso"),
                      InfoItem(label: "Status dalam Keluarga", value: "Kepala Keluarga"),
                      InfoItem(label: "Alamat", value: "Jl. Kenanga No. 12, RT 03/RW 05"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // INFORMASI PEKERJAAN & PENDIDIKAN
                  // =====================================================
                  const Text(
                    "Pekerjaan & Pendidikan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  InfoCard(
                    items: [
                      InfoItem(label: "Pekerjaan", value: "Pegawai Swasta"),
                      InfoItem(label: "Pendidikan Terakhir", value: "S1"),
                      InfoItem(label: "Nama Perusahaan", value: "PT. Maju Jaya"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // INFORMASI KONTAK
                  // =====================================================
                  const Text(
                    "Informasi Kontak",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  InfoCard(
                    items: [
                      InfoItem(label: "No. Telepon", value: "0812-3456-7890"),
                      InfoItem(label: "Email", value: "budi.santoso@email.com"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // ACTION BUTTONS
                  // =====================================================
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditWargaPage(
                                  name: name,
                                  nik: nik,
                                  gender: gender,
                                  age: age,
                                  rt: rt,
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: Icon(Icons.edit_outlined, size: 20, color: Colors.grey[700]),
                          label: Text(
                            "Edit Data",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showDeleteDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.delete_outline, size: 20, color: Colors.white),
                          label: const Text(
                            "Hapus Data",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Hapus Data Warga?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E1E),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Apakah Anda yakin ingin menghapus data warga ini? Tindakan ini tidak dapat dibatalkan.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.cyan,
                        side: const BorderSide(color: Colors.cyan, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Batal"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        Navigator.pop(context); // Close detail page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Hapus"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
