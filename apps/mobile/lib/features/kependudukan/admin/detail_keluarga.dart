import 'package:flutter/material.dart';
import 'widgets/kependudukan_widgets.dart';
import 'edit_keluarga.dart';

class DetailKeluargaPage extends StatelessWidget {
  final String name;
  final String kk;
  final String address;
  final String rt;

  const DetailKeluargaPage({
    super.key,
    required this.name,
    required this.kk,
    required this.address,
    required this.rt,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // =====================================================
          // SLIVER APP BAR
          // =====================================================
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
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
                      const Color(0xFF00AFC1),
                      const Color(0xFF00AFC1).withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.badge_outlined, color: Colors.white.withOpacity(0.9), size: 18),
                            const SizedBox(width: 6),
                            Text(
                              "KK: $kk",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.95),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: Colors.white.withOpacity(0.9), size: 18),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                address,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.95),
                                ),
                              ),
                            ),
                          ],
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
                  // STATISTIK KELUARGA
                  // =====================================================
                  const Text(
                    "Statistik Keluarga",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.groups_outlined,
                          label: "Total Anggota",
                          value: "5",
                          color: const Color(0xFF00AFC1),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.male_outlined,
                          label: "Laki-laki",
                          value: "3",
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.female_outlined,
                          label: "Perempuan",
                          value: "2",
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.child_care_outlined,
                          label: "Anak-anak",
                          value: "2",
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // INFORMASI KEPALA KELUARGA
                  // =====================================================
                  const Text(
                    "Kepala Keluarga",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  InfoCard(
                    items: [
                      InfoItem(label: "Nama Lengkap", value: name),
                      InfoItem(label: "NIK", value: "3201012408900001"),
                      InfoItem(label: "Tempat, Tanggal Lahir", value: "Jakarta, 24 Agustus 1990"),
                      InfoItem(label: "Jenis Kelamin", value: "Laki-laki"),
                      InfoItem(label: "Agama", value: "Islam"),
                      InfoItem(label: "Pekerjaan", value: "Pegawai Swasta"),
                      InfoItem(label: "Status Perkawinan", value: "Kawin"),
                      InfoItem(label: "Pendidikan Terakhir", value: "S1"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // ANGGOTA KELUARGA
                  // =====================================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Anggota Keluarga",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // TODO: Navigate to add member page
                        },
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text("Tambah"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  MemberCard(
                    name: "Siti Nurhaliza",
                    nik: "3201012408900002",
                    relation: "Istri",
                    age: "32 tahun",
                    gender: "Perempuan",
                    onTap: () {
                      // TODO: Navigate to member detail
                    },
                  ),
                  const SizedBox(height: 12),

                  MemberCard(
                    name: "Ahmad Fauzi",
                    nik: "3201012408900003",
                    relation: "Anak",
                    age: "10 tahun",
                    gender: "Laki-laki",
                    onTap: () {
                      // TODO: Navigate to member detail
                    },
                  ),
                  const SizedBox(height: 12),

                  MemberCard(
                    name: "Fatimah Azzahra",
                    nik: "3201012408900004",
                    relation: "Anak",
                    age: "7 tahun",
                    gender: "Perempuan",
                    onTap: () {
                      // TODO: Navigate to member detail
                    },
                  ),
                  const SizedBox(height: 12),

                  MemberCard(
                    name: "Muhammad Rizki",
                    nik: "3201012408900005",
                    relation: "Anak",
                    age: "5 tahun",
                    gender: "Laki-laki",
                    onTap: () {
                      // TODO: Navigate to member detail
                    },
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
                                builder: (context) => EditKeluargaPage(
                                  name: name,
                                  kk: kk,
                                  address: address,
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
                "Hapus Data Keluarga?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E1E),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Apakah Anda yakin ingin menghapus data keluarga ini? Tindakan ini tidak dapat dibatalkan.",
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
