import 'package:flutter/material.dart';
import '../../../models/searchbar.dart';
import '../../../models/bottom_navbar_warga.dart';
import '../../../models/filter_category_blue.dart'; 

class KegiatanWargaPage extends StatefulWidget {
  const KegiatanWargaPage({super.key});

  @override
  State<KegiatanWargaPage> createState() => _KegiatanWargaPageState();
}

class _KegiatanWargaPageState extends State<KegiatanWargaPage> {

  int selectedCategoryIndex = 0;

  final List<String> categories = [
    "Semua",
    "Sosial",
    "Kesehatan",
    "Keamanan",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Kegiatan Warga",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= SEARCH =================
            CustomSearchBar(
              hintText: "Cari data kegiatan...",
              onChanged: (value) {
                print("Search input: $value");
              },
            ),

            const SizedBox(height: 14),

            // ================= FILTER =================
            FilterCategory(
              items: categories,
              selectedIndex: selectedCategoryIndex,
              onSelected: (index) {
                setState(() {
                  selectedCategoryIndex = index;
                });
              },
            ),

            const SizedBox(height: 16),

            // ================= LIST =================
            Expanded(
              child: ListView(
                children: const [
                  KegiatanCard(
                    day: "28",
                    month: "Nov",
                    title: "Kerja Bakti Lingkungan",
                    time: "07:00 - 10:00 WIB",
                    location: "Lapangan RT 03",
                    participants: "45 peserta",
                  ),
                  KegiatanCard(
                    day: "NaN",
                    month: "Invalid",
                    title: "Arisan Ibu-ibu PKK",
                    time: "14:00 - 16:00 WIB",
                    location: "Balai RW 05",
                    participants: "30 peserta",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class KegiatanCard extends StatelessWidget {
  final String day;
  final String month;
  final String title;
  final String time;
  final String location;
  final String participants;

  const KegiatanCard({
    super.key,
    required this.day,
    required this.month,
    required this.title,
    required this.time,
    required this.location,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ===== DATE =====
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  month,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // ===== CONTENT =====
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Akan Datang",
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.schedule, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(time, style: const TextStyle(color: Colors.grey)),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(location, style: const TextStyle(color: Colors.grey)),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(Icons.group, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(participants,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


