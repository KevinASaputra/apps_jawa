import 'package:flutter/material.dart';

class RegisterChoicePage extends StatelessWidget {
  const RegisterChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cyan = Colors.cyan[600];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // 🔵 ICON / HEADER MODERN
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: cyan!.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.group_add_rounded,
                  size: 50,
                  color: cyan,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Pilih Jenis Pendaftaran",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: cyan,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Silakan pilih metode pendaftaran yang sesuai",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 40),

              // 🔹 CARD UTAMA PILIHAN
              _OptionCard(
                icon: Icons.home_rounded,
                title: "Register 1 Keluarga",
                subtitle: "Buat akun sekaligus dengan data keluarga & anggota",
                color: cyan,
                onTap: () => Navigator.pushNamed(context, '/registerKeluarga'),
              ),

              const SizedBox(height: 20),

              _OptionCard(
                icon: Icons.person_add_alt_1_rounded,
                title: "Register Warga Saja",
                subtitle: "Daftar sebagai individu tanpa membuat data keluarga",
                color: cyan,
                onTap: () => Navigator.pushNamed(context, '/registerWarga'),
              ),

              const Spacer(),

              // FOOTER
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "© 2025 Jawara Pintar • All Rights Reserved",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// 🔥 MODERN OPTION CARD COMPONENT
//

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            // ICON WRAPPER
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 30),
            ),

            const SizedBox(width: 16),

            // TEXTS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
