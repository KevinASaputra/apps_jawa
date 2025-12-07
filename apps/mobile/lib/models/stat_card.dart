import 'package:flutter/material.dart';

// ===================
// Reusable StatCard
// ===================
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;
  final Color iconBackground;
  final Color iconColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.iconBackground = const Color(0xFFE5F8FB),
    this.iconColor = const Color(0xFF00AFC1),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Circle
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? _getIconForTitle(title),
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(height: 15),

          // Value
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 6),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Default icon based on title
  IconData _getIconForTitle(String title) {
    switch (title.toLowerCase()) {
      case 'total warga':
        return Icons.people;
      case 'aktif':
        return Icons.check_circle;
      case 'tidak aktif':
        return Icons.cancel;
      case 'pemasukan':
        return Icons.arrow_upward;
      case 'pengeluaran':
        return Icons.arrow_downward;
      default:
        return Icons.insert_chart;
    }
  }
}
