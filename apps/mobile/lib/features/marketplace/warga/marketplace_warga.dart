import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'batik_detection_page.dart';
import 'detail_produk_batik.dart';
import 'widget/product_card_warga.dart';
import 'widget/category_chip.dart';

class MarketplaceWarga extends StatefulWidget {
  const MarketplaceWarga({super.key});

  @override
  State<MarketplaceWarga> createState() => _MarketplaceWargaState();
}

class _MarketplaceWargaState extends State<MarketplaceWarga> {
  String selectedCategory = 'Semua';
  final TextEditingController _searchController = TextEditingController();
  
  // Dummy data produk batik
  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Batik Parang Rusak',
      'motif': 'Parang',
      'price': 250000,
      'seller': 'Toko Batik Jaya',
      'image': 'https://via.placeholder.com/150',
      'rating': 4.5,
      'sold': 120,
      'stock': 15,
      'description': 'Batik tulis dengan motif parang rusak khas Jogja',
    },
    {
      'id': 2,
      'name': 'Batik Kawung Premium',
      'motif': 'Kawung',
      'price': 350000,
      'seller': 'Batik Nusantara',
      'image': 'https://via.placeholder.com/150',
      'rating': 4.8,
      'sold': 85,
      'stock': 10,
      'description': 'Batik cap motif kawung dengan kualitas premium',
    },
    {
      'id': 3,
      'name': 'Batik Mega Mendung',
      'motif': 'Mega Mendung',
      'price': 300000,
      'seller': 'Cirebon Batik',
      'image': 'https://via.placeholder.com/150',
      'rating': 4.6,
      'sold': 95,
      'stock': 20,
      'description': 'Batik mega mendung khas Cirebon dengan warna cerah',
    },
    {
      'id': 4,
      'name': 'Batik Truntum',
      'motif': 'Truntum',
      'price': 280000,
      'seller': 'Batik Heritage',
      'image': 'https://via.placeholder.com/150',
      'rating': 4.7,
      'sold': 110,
      'stock': 12,
      'description': 'Batik truntum dengan makna cinta yang tumbuh',
    },
  ];

  List<String> categories = ['Semua', 'Parang', 'Kawung', 'Mega Mendung', 'Truntum', 'Sido Mukti'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 'Semua') {
      return products;
    }
    return products.where((p) => p['motif'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Marketplace Batik',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar & Camera Button
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Cari produk batik...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Camera Button for Batik Detection
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6366F1).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => const BatikDetectionPage());
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Info banner untuk fitur kamera
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF6366F1).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: const Color(0xFF6366F1),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Tap ikon kamera untuk mendeteksi motif batik!',
                          style: TextStyle(
                            color: const Color(0xFF6366F1),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Category Filter
          Container(
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryChip(
                  label: categories[index],
                  isSelected: selectedCategory == categories[index],
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                    });
                  },
                );
              },
            ),
          ),

          // Products Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada produk',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductCardWarga(
                        product: product,
                        onTap: () {
                          Get.to(() => DetailProdukBatik(product: product));
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
