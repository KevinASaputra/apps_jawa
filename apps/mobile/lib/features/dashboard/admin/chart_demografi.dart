import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartDemografiPage extends StatelessWidget {
  const ChartDemografiPage({super.key});

  @override
  Widget build(BuildContext context) {
    const int laki = 245;
    const int perempuan = 238;
    final total = laki + perempuan;

    final double persenLaki = (laki / total) * 100;
    final double persenPerempuan = (perempuan / total) * 100;

    return _buildCard(
      title: "Demografi Penduduk",
      child: Column(
        children: [
          SizedBox(
            height: 220,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 55,
                startDegreeOffset: 270,
                sections: [
                  PieChartSectionData(
                    color: const Color(0xff0097A7),
                    value: laki.toDouble(),
                    radius: 40,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    color: Colors.orange,
                    value: perempuan.toDouble(),
                    radius: 40,
                    showTitle: false,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Persen di tengah chart
          Text(
            "${persenLaki.toStringAsFixed(0)}% • Laki-laki",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff0097A7),
              fontSize: 14,
            ),
          ),
          Text(
            "${persenPerempuan.toStringAsFixed(0)}% • Perempuan",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 20),

          // Legend bagian bawah (seperti contoh)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legend(color: Color(0xff0097A7), text: "Laki-laki: $laki"),
              const SizedBox(width: 20),
              _legend(color: Colors.orange, text: "Perempuan: $perempuan"),
            ],
          ),
        ],
      ),
    );
  }
}

// -------------------------
// REUSABLE CARD
// -------------------------
Widget _buildCard({required String title, required Widget child}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 4),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        child,
      ],
    ),
  );
}

// -------------------------
// LEGEND ITEM
// -------------------------
Widget _legend({required Color color, required String text}) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 6),
      Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[700],
          fontWeight: FontWeight.w500,
        ),
      )
    ],
  );
}
