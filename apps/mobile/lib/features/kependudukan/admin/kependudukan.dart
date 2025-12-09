import 'package:flutter/material.dart';
import '../../../models/buttom_navbar.dart';
import 'detail_keluarga.dart';
import 'detail_warga.dart';
import 'tambah_keluarga.dart';
import 'tambah_warga.dart';

class KependudukanPage extends StatefulWidget {
  const KependudukanPage({super.key});

  @override
  State<KependudukanPage> createState() => _KependudukanPageState();
}

class _KependudukanPageState extends State<KependudukanPage> {
  int selectedMenu = 0; // 0 = Keluarga, 1 = Warga
  String selectedRt = "RT 03";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedMenu == 0) {
            // Add Keluarga
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TambahKeluargaPage()),
            );
          } else {
            // Add Warga
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TambahWargaPage()),
            );
          }
        },
        backgroundColor: const Color(0xFF00AFC1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Kependudukan"),
      ),

      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =====================================================
              // SWITCH MENU (Keluarga / Warga)
              // =====================================================
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF3F8),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    menuButton("Keluarga", 0),
                    menuButton("Warga", 1),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // =====================================================
              // SEARCH BAR
              // =====================================================
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.04),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[600]),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Cari keluarga...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // =====================================================
              // FILTER RT
              // =====================================================
              Wrap(
                spacing: 10,
                children: ["RT 01", "RT 02", "RT 03", "RT 04"].map((rt) {
                  bool active = rt == selectedRt;
                  return GestureDetector(
                    onTap: () => setState(() => selectedRt = rt),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: active ? const Color(0xFF00AFC1) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: active ? const Color(0xFF00AFC1) : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        rt,
                        style: TextStyle(
                          color: active ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 25),

              // =====================================================
              // CONDITIONAL LIST (Keluarga / Warga)
              // =====================================================
              if (selectedMenu == 0) ...[
                // LIST KELUARGA
                familyCard(
                  name: "Budi Santoso",
                  kk: "3201012408900001",
                  address: "Jl. Kenanga No. 12",
                  rt: "RT 03",
                ),
                const SizedBox(height: 14),

                familyCard(
                  name: "Ahmad Yani",
                  kk: "3201012408900002",
                  address: "Jl. Melati No. 8",
                  rt: "RT 03",
                ),
              ] else ...[
                // LIST WARGA
                wargaCard(
                  name: "Budi Santoso",
                  nik: "3201012408900001",
                  gender: "Laki-laki",
                  age: "34 tahun",
                  rt: "RT 03",
                ),
                const SizedBox(height: 14),

                wargaCard(
                  name: "Siti Nurhaliza",
                  nik: "3201012408900002",
                  gender: "Perempuan",
                  age: "32 tahun",
                  rt: "RT 03",
                ),
                const SizedBox(height: 14),

                wargaCard(
                  name: "Ahmad Fauzi",
                  nik: "3201012408900003",
                  gender: "Laki-laki",
                  age: "10 tahun",
                  rt: "RT 03",
                ),
                const SizedBox(height: 14),

                wargaCard(
                  name: "Ahmad Yani",
                  nik: "3201012408900010",
                  gender: "Laki-laki",
                  age: "45 tahun",
                  rt: "RT 03",
                ),
                const SizedBox(height: 14),

                wargaCard(
                  name: "Dewi Sartika",
                  nik: "3201012408900011",
                  gender: "Perempuan",
                  age: "28 tahun",
                  rt: "RT 03",
                ),
              ],

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // MENU BUTTON (Keluarga / Warga)
  // =====================================================
  Widget menuButton(String text, int index) {
    bool active = selectedMenu == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedMenu = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: active ? const Color(0xFF00AFC1) : Colors.grey[700],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // CARD KELUARGA
  // =====================================================
  Widget familyCard({
    required String name,
    required String kk,
    required String address,
    required String rt,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailKeluargaPage(
              name: name,
              kk: kk,
              address: address,
              rt: rt,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            // LEFT SIDE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(width: 6),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7F8FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          rt,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF00AFC1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),
                  Text("KK: $kk", style: TextStyle(color: Colors.grey[700])),
                  Text(address, style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),

            Icon(Icons.chevron_right, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // CARD WARGA
  // =====================================================
  Widget wargaCard({
    required String name,
    required String nik,
    required String gender,
    required String age,
    required String rt,
  }) {
    IconData genderIcon = gender.toLowerCase() == "laki-laki" 
        ? Icons.male_outlined 
        : Icons.female_outlined;
    Color genderColor = gender.toLowerCase() == "laki-laki" 
        ? Colors.blue 
        : Colors.pink;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailWargaPage(
              name: name,
              nik: nik,
              gender: gender,
              age: age,
              rt: rt,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            // GENDER ICON
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: genderColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(genderIcon, color: genderColor, size: 28),
            ),

            const SizedBox(width: 14),

            // WARGA INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(width: 6),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7F8FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          rt,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF00AFC1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),
                  Text("NIK: $nik", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.cake_outlined, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(age, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),

            Icon(Icons.chevron_right, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
