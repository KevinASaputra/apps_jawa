import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/buttom_navbar.dart';
import 'chart_demografi.dart';
import 'kegiatan_terdekat.dart';
import 'chart_keuangan.dart';
import '../../../models/searchbar.dart';
import '../../../models/stat_card.dart';
import '../../../models/quickaction_button.dart';
import '../../kependudukan/admin/kependudukan.dart';
import '../../lainnya/kegiatan_warga.dart';
import '../../keuangan/admin/keuangan.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    const Color cyan = Color(0xFF00AFC1);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ====================================================
              //                       HEADER
              // ====================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 30),
                decoration: BoxDecoration(
                  color: cyan,
                  gradient: LinearGradient(
                    colors: [
                      cyan,
                      cyan.withOpacity(0.88),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Selamat Datang",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Halo, Admin 👋",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ================= SEARCH BAR =================
                    CustomSearchBar(
                      hintText: "Cari data warga...",
                      onChanged: (value) {
                        // lakukan filter data di sini
                        print("Search input: $value");
                      },
                    ),

                    const SizedBox(height: 20),

                    // ================= STAT CARDS =================
                    SizedBox(
                      height: 155,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          StatCard(title: "Total Keluarga", value: "156"),
                          StatCard(title: "Total Warga", value: "482"),
                          StatCard(title: "Saldo Kas", value: "Rp 12.500.000"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ====================================================
              //                   AKSI CEPAT
              // ====================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Aksi Cepat",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Colors.grey[800],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    QuickActionButton(
                      icon: CupertinoIcons.person_badge_plus,
                      label: "Tambah Warga",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KependudukanPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    QuickActionButton(
                      icon: CupertinoIcons.calendar_badge_plus,
                      label: "Tambah Kegiatan",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KegiatanWargaPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    QuickActionButton(
                      icon: CupertinoIcons.doc_plaintext,
                      label: "Laporan",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KeuanganPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ====================================================
              //                     DEMOGRAFI
              // ====================================================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ChartDemografiPage(),
              ),

              const SizedBox(height: 30),

              // ===============================
              //        KEUANGAN BULANAN
              // ===============================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ChartKeuangan(
                  data: {
                    "Januari": {"pemasukan": 5000000, "pengeluaran": 2000000},
                    "Februari": {"pemasukan": 4500000, "pengeluaran": 2500000},
                    "Maret": {"pemasukan": 6000000, "pengeluaran": 3000000},
                    "April": {"pemasukan": 5500000, "pengeluaran": 2200000},
                    "Mei": {"pemasukan": 7000000, "pengeluaran": 3500000},
                    "Juni": {"pemasukan": 6500000, "pengeluaran": 2800000},
                  },
                ),
              ),

              const SizedBox(height: 30),

              const SizedBox(height: 30),

              // ====================================================
              //                     KEGIATAN
              // ====================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Kegiatan Terdekat",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Colors.grey[800],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const KegiatanTerdekat(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

