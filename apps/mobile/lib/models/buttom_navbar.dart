import 'dart:ui';
import 'package:flutter/material.dart';
import '../../features/dashboard/admin/dashboard.dart';
import '../features/kependudukan/admin/kependudukan.dart';
import '../features/keuangan/admin/keuangan.dart';
import '../features/marketplace/admin/marketplace.dart';
import '../features/lainnya/lainnya.dart';

class AppBottomNavBar extends StatefulWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  void onTabTapped(int index) {
    Widget page;

    switch (index) {
      case 0:
        page = const AdminDashboard();
        break;
      case 1:
        page = const KependudukanPage();
        break;
      case 2:
        page = const KeuanganPage();
        break;
      case 3:
        page = const MarketplacePage();
        break;
      case 4:
      default:
        page = const LainnyaPage();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 14),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem(Icons.home, "Beranda", 0),
              navItem(Icons.people, "Kependudukan", 1),
              navItem(Icons.account_balance, "Keuangan", 2),
              navItem(Icons.store, "Marketplace", 3),
              navItem(Icons.more_horiz, "Lainnya", 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String label, int index) {
    bool active = widget.currentIndex == index;

    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: const BoxDecoration(
          color: Colors.transparent, // tidak ada background active sama sekali
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 150),
              scale: active ? 1.22 : 1.0,
              child: Icon(
                icon,
                color: active ? Colors.cyan : Colors.grey[600],
                size: 22,
                shadows: active
                    ? [
                        Shadow(
                          color: Colors.cyan.withOpacity(0.4),
                          blurRadius: 6,
                        )
                      ]
                    : [],
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                color: active ? Colors.cyan : Colors.grey[600],
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
