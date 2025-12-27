import 'dart:async';
import 'package:flutter/material.dart';
import 'batik_detection_page.dart';
import 'batik_camera_page.dart';
import 'detail_produk_batik.dart';
import 'cart_page.dart';
import 'sell_product_page.dart';
import 'my_products_page.dart';
import 'widget/product_card_warga.dart';
import 'widget/category_chip.dart';
import '../../../models/bottom_navbar_warga.dart';
import '../../../services/auth_service.dart';

class MarketplaceWarga extends StatefulWidget {
  const MarketplaceWarga({super.key});

  @override
  State<MarketplaceWarga> createState() => _MarketplaceWargaState();
}

class _MarketplaceWargaState extends State<MarketplaceWarga> {
  String selectedCategory = 'Semua';
  String? detectedMotif; // Motif dari hasil camera detection
  final TextEditingController _searchController = TextEditingController();
  String? userRole;

  // Stream controller for products
  final StreamController<List<Map<String, dynamic>>> _productStreamController =
      StreamController();

  @override
  void initState() {
    super.initState();
    _loadUserRole();
    _startProductStream();
  }

  Future<void> _loadUserRole() async {
    final role = await AuthService().getUserRole();
    setState(() {
      userRole = role;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _productStreamController.close(); // Close the stream controller
    super.dispose();
  }

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

  List<String> categories = [
    'Semua',
    'Termurah',
    'Termahal',
    'Rating Tertinggi',
    'Terlaris',
    'Stok Terbanyak',
  ];

  // Function to simulate product stream
  void _startProductStream() {
    List<Map<String, dynamic>> allProducts = List.from(
      products,
    ); // Clone the initial products

    // Simulate adding more products over time
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (allProducts.length >= 100) {
        timer.cancel(); // Stop adding products after reaching 100
      } else {
        allProducts.add({
          'id': allProducts.length + 1,
          'name': 'Batik ${allProducts.length + 1}',
          'motif': 'Motif ${allProducts.length + 1}',
          'price': 200000 + (allProducts.length * 1000),
          'seller': 'Seller ${allProducts.length + 1}',
          'image': 'https://via.placeholder.com/150',
          'rating': 4.0 + (allProducts.length % 5) * 0.1,
          'sold': allProducts.length * 10,
          'stock': 50 - (allProducts.length % 10),
          'description': 'Deskripsi produk batik ${allProducts.length + 1}',
        });
        _productStreamController.add(
          List.from(allProducts),
        ); // Add updated list to the stream
      }
    });
  }

  List<Map<String, dynamic>> get filteredProducts {
    var result = products;

    // Filter by detected motif from camera
    if (detectedMotif != null && detectedMotif!.isNotEmpty) {
      result = result.where((p) {
        final motif = p['motif'].toString().toLowerCase();
        final detected = detectedMotif!.toLowerCase();
        return motif.contains(detected) || detected.contains(motif);
      }).toList();
    }

    // Sort/Filter by selected category
    if (selectedCategory != 'Semua') {
      switch (selectedCategory) {
        case 'Termurah':
          result.sort((a, b) => a['price'].compareTo(b['price']));
          break;
        case 'Termahal':
          result.sort((a, b) => b['price'].compareTo(a['price']));
          break;
        case 'Rating Tertinggi':
          result.sort((a, b) => b['rating'].compareTo(a['rating']));
          break;
        case 'Terlaris':
          result.sort((a, b) => b['sold'].compareTo(a['sold']));
          break;
        case 'Stok Terbanyak':
          result.sort((a, b) => b['stock'].compareTo(a['stock']));
          break;
      }
    }

    // Filter by search text
    final searchText = _searchController.text.toLowerCase();
    if (searchText.isNotEmpty) {
      result = result.where((p) {
        final name = p['name'].toString().toLowerCase();
        final motif = p['motif'].toString().toLowerCase();
        final seller = p['seller'].toString().toLowerCase();
        return name.contains(searchText) ||
            motif.contains(searchText) ||
            seller.contains(searchText);
      }).toList();
    }

    return result;
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
          if (userRole == 'Seller') // Only show for Seller
            IconButton(
              icon: const Icon(Icons.store_outlined),
              tooltip: 'Produk Saya',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyProductsPage(),
                  ),
                );
              },
            ),
          IconButton(
            icon: Badge(
              label: const Text('2'),
              backgroundColor: Colors.red,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
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
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF00AFC1),
                            const Color(0xFF00AFC1).withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00AFC1).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // Show option: Camera Realtime atau Upload
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) => Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      'Deteksi Motif Batik',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    // Camera Real-time
                                    ListTile(
                                      leading: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF00AFC1,
                                          ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Color(0xFF00AFC1),
                                        ),
                                      ),
                                      title: const Text(
                                        'Camera Real-time',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: const Text(
                                        'Deteksi otomatis setiap 3 detik',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      trailing: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: const Text(
                                          'NEW',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BatikCameraPage(),
                                          ),
                                        );

                                        // Set detected motif and filter products
                                        if (result != null &&
                                            result is String) {
                                          setState(() {
                                            detectedMotif = result;
                                            selectedCategory = 'Semua';
                                            _searchController.clear();
                                          });

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '🎯 Menampilkan produk dengan motif: $result',
                                              ),
                                              backgroundColor: const Color(
                                                0xFF00AFC1,
                                              ),
                                              duration: const Duration(
                                                seconds: 3,
                                              ),
                                              action: SnackBarAction(
                                                label: 'Reset',
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  setState(() {
                                                    detectedMotif = null;
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    const Divider(),
                                    // Upload/Gallery
                                    ListTile(
                                      leading: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.photo_library,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      title: const Text(
                                        'Upload Foto',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: const Text(
                                        'Pilih dari galeri atau ambil foto',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BatikDetectionPage(),
                                          ),
                                        );

                                        // Set detected motif and filter products
                                        if (result != null &&
                                            result is String) {
                                          setState(() {
                                            detectedMotif = result;
                                            selectedCategory = 'Semua';
                                            _searchController.clear();
                                          });

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '🎯 Menampilkan produk dengan motif: $result',
                                              ),
                                              backgroundColor: const Color(
                                                0xFF00AFC1,
                                              ),
                                              duration: const Duration(
                                                seconds: 3,
                                              ),
                                              action: SnackBarAction(
                                                label: 'Reset',
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  setState(() {
                                                    detectedMotif = null;
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
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

          // Detected Motif Banner (if exists)
          if (detectedMotif != null && detectedMotif!.isNotEmpty)
            Container(
              color: const Color(0xFF00AFC1).withOpacity(0.1),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: const Color(0xFF00AFC1),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Filter aktif: Motif "$detectedMotif" terdeteksi',
                      style: const TextStyle(
                        color: Color(0xFF00AFC1),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        detectedMotif = null;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Hapus',
                      style: TextStyle(
                        color: Color(0xFF00AFC1),
                        fontWeight: FontWeight.bold,
                      ),
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
                      detectedMotif =
                          null; // Clear camera filter when selecting category
                    });
                  },
                );
              },
            ),
          ),

          // Products Count
          if (filteredProducts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Text(
                '${filteredProducts.length} produk ditemukan',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          // Product StreamBuilder
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _productStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada produk'));
                }

                final products = snapshot.data!;

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCardWarga(
                      product: product,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailProdukBatik(product: product),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton:
          userRole ==
              'Seller' // Only show for Seller
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SellProductPage(),
                  ),
                );
              },
              label: const Text('Jual Batik'),
              icon: const Icon(Icons.add),
              backgroundColor: const Color(0xFF00AFC1),
            )
          : null,
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }
}
