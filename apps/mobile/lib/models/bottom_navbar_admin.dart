import 'dart:ui';
import 'package:flutter/material.dart';
import '../../features/dashboard/admin/dashboard.dart';
import '../features/kependudukan/admin/kependudukan.dart';
import '../features/keuangan/admin/keuangan.dart';
import '../features/marketplace/admin/marketplace.dart';
import '../features/lainnya/admin/lainnya.dart';

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
          child: Row(children: const [
            Expanded(child: _NavItem(icon: Icons.home, label: "Beranda", index: 0)),
            Expanded(child: _NavItem(icon: Icons.people, label: "Kependudukan", index: 1)),
            Expanded(child: _NavItem(icon: Icons.account_balance, label: "Keuangan", index: 2)),
            Expanded(child: _NavItem(icon: Icons.store, label: "Marketplace", index: 3)),
            Expanded(child: _NavItem(icon: Icons.more_horiz, label: "Lainnya", index: 4)),
          ]),
        ),
      ),
    );
  }

  void onNavTap(int index) => onTabTapped(index);
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_AppBottomNavBarState>();
    final active = state?.widget.currentIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => state?.onNavTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 150),
              scale: active ? 1.18 : 1.0,
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
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: active ? Colors.cyan : Colors.grey[600],
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ],
        ),
      ),
    );
  }
}
