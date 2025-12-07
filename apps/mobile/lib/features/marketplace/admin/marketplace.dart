import 'package:flutter/material.dart';
import '../../../models/buttom_navbar.dart';
import '../../../models/searchbar.dart';
import 'product_card.dart';
import 'stat_card.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fa),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          "Marketplace Batik Warga",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),

      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= STAT CARDS =================
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                physics: const BouncingScrollPhysics(),
                children: const [
                  SizedBox(width: 12),
                  StatCard(
                    icon: Icons.shopping_bag,
                    total: "120",
                    title: "Produk",
                    color: Colors.brown,
                  ),
                  SizedBox(width: 14),
                  StatCard(
                    icon: Icons.people,
                    total: "89",
                    title: "UMKM",
                    color: Colors.orange,
                  ),
                  SizedBox(width: 14),
                  StatCard(
                    icon: Icons.check_circle,
                    total: "65",
                    title: "Verified",
                    color: Colors.green,
                  ),
                  SizedBox(width: 14),
                  StatCard(
                    icon: Icons.sell,
                    total: "332",
                    title: "Terjual",
                    color: Colors.blue,
                  ),
                  SizedBox(width: 12),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= ADMIN BANNER =================
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100.withOpacity(0.55),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.admin_panel_settings,
                      color: Colors.brown, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Anda sedang dalam mode Admin. Anda dapat memantau produk marketplace warga namun tidak dapat mengedit langsung.",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.3,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= SEARCH BAR =================
            CustomSearchBar(
              hintText: "Cari data batik, penjual...",
              onChanged: (value) {},
            ),

            const SizedBox(height: 20),

            // ================= PRODUCTS =================
            ProductCard(
              image: "assets/batik_parang.jpg",
              title: "Kemeja Batik Tulis Motif Parang",
              price: "Rp 285.000",
              umkm: "UMKM Lastri",
              stok: "8",
              rt: "RT 03",
              kategori: "Pakaian Batik",
              description: "Kemeja batik tulis premium dengan motif parang klasik. Cocok untuk acara formal maupun semi formal. Bahan katun halus, nyaman dipakai seharian.",
            ),

            ProductCard(
              image: "assets/batik_kawung.jpg",
              title: "Dress Batik Motif Kawung",
              price: "Rp 350.000",
              umkm: "UMKM Maya",
              stok: "4",
              rt: "RT 01",
              kategori: "Pakaian Batik",
              description: "Dress batik elegan dengan motif kawung. Cocok untuk berbagai acara formal. Bahan premium dengan jahitan rapi dan detail yang menawan.",
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
