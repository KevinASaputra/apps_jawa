import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class KegiatanTerdekat extends StatelessWidget {
  const KegiatanTerdekat({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TITLE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFE5F2FF),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  CupertinoIcons.calendar,
                  color: Color(0xFF00AEEF),
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Kegiatan Terdekat",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),

        const SizedBox(height: 15),

        // LIST SCROLL HORIZONTAL
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _cardKegiatan(
                title: "Kerja Bakti Mingguan",
                date: "Minggu, 10 Des 2025",
                color: Colors.blue.shade50,
                icon: CupertinoIcons.shield_fill,
              ),
              _cardKegiatan(
                title: "Rapat Bulanan RT",
                date: "Sabtu, 16 Des 2025",
                color: Colors.green.shade50,
                icon: CupertinoIcons.group_solid,
              ),
              _cardKegiatan(
                title: "Posyandu Balita",
                date: "Rabu, 20 Des 2025",
                color: Colors.orange.shade50,
                icon: CupertinoIcons.heart_fill,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _cardKegiatan({
  required String title,
  required String date,
  required Color color,
  required IconData icon,
}) {
  return Container(
    width: 220,
    margin: const EdgeInsets.only(right: 15),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ICON
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(icon, size: 22, color: Colors.black87),
        ),
        const SizedBox(height: 12),

        // TITLE
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 6),

        // DATE
        Row(
          children: [
            const Icon(
              CupertinoIcons.time,
              size: 16,
              color: Colors.black54,
            ),
            const SizedBox(width: 6),
            Text(
              date,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ],
    ),
  );
}
