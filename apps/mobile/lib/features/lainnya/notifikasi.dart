import 'package:flutter/material.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Notifikasi"),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: const Text(
              "Tandai Semua",
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationCard(
            icon: Icons.account_balance_wallet,
            iconColor: Colors.green,
            iconBgColor: Colors.green.withOpacity(0.1),
            title: "Pemasukan Baru",
            subtitle: "Iuran Sampah November sebesar Rp 2.500.000 telah diterima",
            time: "2 jam yang lalu",
            isNew: true,
          ),

          const SizedBox(height: 12),

          _buildNotificationCard(
            icon: Icons.event,
            iconColor: Colors.blue,
            iconBgColor: Colors.blue.withOpacity(0.1),
            title: "Pengingat Kegiatan",
            subtitle: "Kerja Bakti Lingkungan akan dimulai besok pukul 07:00 WIB",
            time: "4 jam yang lalu",
            isNew: true,
          ),

          const SizedBox(height: 12),

          _buildNotificationCard(
            icon: Icons.shopping_bag,
            iconColor: Colors.purple,
            iconBgColor: Colors.purple.withOpacity(0.1),
            title: "Pesanan Baru",
            subtitle: "Ada pesanan baru untuk Nasi Goreng Spesial dari Ibu Ani",
            time: "6 jam yang lalu",
            isNew: true,
          ),

          const SizedBox(height: 12),

          _buildNotificationCard(
            icon: Icons.group_add,
            iconColor: Colors.blue,
            iconBgColor: Colors.blue.withOpacity(0.1),
            title: "Data Warga Baru",
            subtitle: "Keluarga baru telah ditambahkan ke RT 03",
            time: "1 hari yang lalu",
            isNew: false,
          ),

          const SizedBox(height: 12),

          _buildNotificationCard(
            icon: Icons.payment,
            iconColor: Colors.red,
            iconBgColor: Colors.red.withOpacity(0.1),
            title: "Pengeluaran Disetujui",
            subtitle: "Pengeluaran untuk Pembelian Tenda sebesar Rp 1.500.000 telah disetujui",
            time: "2 hari yang lalu",
            isNew: false,
          ),

          const SizedBox(height: 12),

          _buildNotificationCard(
            icon: Icons.check_circle,
            iconColor: Colors.blue,
            iconBgColor: Colors.blue.withOpacity(0.1),
            title: "Kegiatan Selesai",
            subtitle: "Arisan Ibu-ibu PKK telah selesai",
            time: "3 hari yang lalu",
            isNew: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required String time,
    required bool isNew,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isNew
            ? Border.all(color: Colors.cyan.withOpacity(0.3), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                    ),
                    if (isNew)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Baru",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
