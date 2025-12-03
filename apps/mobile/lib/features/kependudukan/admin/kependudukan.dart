import 'package:flutter/material.dart';
import '../../../models/buttom_navbar.dart';

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
              // LIST KELUARGA (Dummy)
              // =====================================================
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
    return Container(
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
    );
  }
}
