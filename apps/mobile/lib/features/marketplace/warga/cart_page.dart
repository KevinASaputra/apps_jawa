import 'package:flutter/material.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Dummy cart items
  List<Map<String, dynamic>> cartItems = [
    {
      'id': 1,
      'name': 'Batik Parang Rusak',
      'motif': 'Parang',
      'price': 250000,
      'seller': 'Toko Batik Jaya',
      'image': 'https://via.placeholder.com/150',
      'quantity': 1,
      'stock': 15,
      'selected': true,
    },
    {
      'id': 2,
      'name': 'Batik Kawung Premium',
      'motif': 'Kawung',
      'price': 350000,
      'seller': 'Batik Nusantara',
      'image': 'https://via.placeholder.com/150',
      'quantity': 2,
      'stock': 10,
      'selected': true,
    },
  ];

  bool get selectAll => cartItems.every((item) => item['selected'] == true);

  int get totalItems =>
      cartItems.where((item) => item['selected'] == true).length;

  int get totalPrice {
    return cartItems
        .where((item) => item['selected'] == true)
        .fold(
          0,
          (sum, item) =>
              sum + (item['price'] as int) * (item['quantity'] as int),
        );
  }

  void toggleSelectAll(bool? value) {
    setState(() {
      for (var item in cartItems) {
        item['selected'] = value ?? false;
      }
    });
  }

  void toggleItemSelection(int index, bool? value) {
    setState(() {
      cartItems[index]['selected'] = value ?? false;
    });
  }

  void updateQuantity(int index, int delta) {
    setState(() {
      final newQuantity = (cartItems[index]['quantity'] as int) + delta;
      if (newQuantity > 0 && newQuantity <= cartItems[index]['stock']) {
        cartItems[index]['quantity'] = newQuantity;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produk dihapus dari keranjang'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const cyan = Color(0xFF00AFC1);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Keranjang',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Keranjang Kosong',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Yuk, belanja batik favoritmu!',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Select All
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectAll,
                        onChanged: toggleSelectAll,
                        activeColor: cyan,
                      ),
                      const Text(
                        'Pilih Semua',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Cart Items List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Checkbox
                              Checkbox(
                                value: item['selected'],
                                onChanged: (value) =>
                                    toggleItemSelection(index, value),
                                activeColor: cyan,
                              ),

                              // Product Image
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[200],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item['image'],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.image, size: 40);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Product Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Motif ${item['motif']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Rp ${item['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: cyan,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Quantity Controls
                                    Row(
                                      children: [
                                        // Delete Button
                                        InkWell(
                                          onTap: () => removeItem(index),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            child: Icon(
                                              Icons.delete_outline,
                                              size: 20,
                                              color: Colors.red[400],
                                            ),
                                          ),
                                        ),
                                        const Spacer(),

                                        // Quantity Controls
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey[300]!,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    updateQuantity(index, -1),
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                                child: Text(
                                                  '${item['quantity']}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () =>
                                                    updateQuantity(index, 1),
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Checkout Bar
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Total ($totalItems item)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Rp ${totalPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: cyan,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: totalItems > 0
                              ? () {
                                  final selectedItems = cartItems
                                      .where((item) => item['selected'] == true)
                                      .toList();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CheckoutPage(items: selectedItems),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cyan,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
