import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/bottom_navbar_warga.dart';
import 'chart_demografi.dart';
import 'kegiatan_terdekat.dart';
import 'chart_keuangan.dart';
import '../../../models/stat_card.dart';

class WargaDashboard extends StatelessWidget {
  const WargaDashboard({super.key});

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
                      "Halo, Warga 👋",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 22),

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

