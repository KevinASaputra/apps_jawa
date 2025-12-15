import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const CheckoutPage({super.key, required this.items});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPayment = 'BCA Virtual Account';
  String selectedShipping = 'JNE Regular';

  final List<Map<String, String>> paymentMethods = [
    {'name': 'BCA Virtual Account', 'icon': '🏦'},
    {'name': 'Mandiri Virtual Account', 'icon': '🏦'},
    {'name': 'OVO', 'icon': '💳'},
    {'name': 'GoPay', 'icon': '💳'},
    {'name': 'ShopeePay', 'icon': '💳'},
  ];

  final List<Map<String, dynamic>> shippingMethods = [
    {'name': 'JNE Regular', 'price': 15000, 'estimate': '3-5 hari'},
    {'name': 'JNE YES', 'price': 25000, 'estimate': '1-2 hari'},
    {'name': 'J&T Express', 'price': 12000, 'estimate': '3-4 hari'},
    {'name': 'SiCepat', 'price': 10000, 'estimate': '4-6 hari'},
  ];

  int get subtotal {
    return widget.items.fold(
      0,
      (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int),
    );
  }

  int get shippingCost {
    final method = shippingMethods.firstWhere(
      (m) => m['name'] == selectedShipping,
      orElse: () => shippingMethods[0],
    );
    return method['price'] as int;
  }

  int get total => subtotal + shippingCost;

  @override
  Widget build(BuildContext context) {
    const cyan = Color(0xFF00AFC1);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: [
                // Shipping Address
                Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: cyan, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Alamat Pengiriman',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // Change address
                            },
                            child: const Text('Ubah'),
                          ),
                        ],
                      ),
                      const Divider(),
                      const Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '+62 812-3456-7890',
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Jl. Batik Nusantara No. 123, Yogyakarta, DI Yogyakarta 55281',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),

                // Products
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.shopping_bag, color: cyan, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Produk Dipesan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      ...widget.items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
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
                                      return const Icon(Icons.image, size: 30);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
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
                                      '${item['quantity']}x Rp ${item['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Rp ${((item['price'] as int) * (item['quantity'] as int)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Shipping Method
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.local_shipping, color: cyan, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Metode Pengiriman',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      ...shippingMethods.map(
                        (method) => RadioListTile<String>(
                          value: method['name'] as String,
                          groupValue: selectedShipping,
                          onChanged: (value) {
                            setState(() {
                              selectedShipping = value!;
                            });
                          },
                          activeColor: cyan,
                          title: Text(
                            method['name'] as String,
                            style: const TextStyle(fontSize: 14),
                          ),
                          subtitle: Text(
                            'Estimasi: ${method['estimate']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          secondary: Text(
                            'Rp ${(method['price'] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Payment Method
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.payment, color: cyan, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Metode Pembayaran',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      ...paymentMethods.map(
                        (method) => RadioListTile<String>(
                          value: method['name']!,
                          groupValue: selectedPayment,
                          onChanged: (value) {
                            setState(() {
                              selectedPayment = value!;
                            });
                          },
                          activeColor: cyan,
                          title: Row(
                            children: [
                              Text(
                                method['icon']!,
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                method['name']!,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Price Summary
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ringkasan Pembayaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      _buildPriceRow('Subtotal', subtotal),
                      const SizedBox(height: 8),
                      _buildPriceRow('Ongkir', shippingCost),
                      const Divider(),
                      _buildPriceRow('Total', total, isTotal: true),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Payment Button
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
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Konfirmasi Pembayaran'),
                        content: Text(
                          'Total pembayaran: Rp ${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}\n\nLanjutkan ke pembayaran?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('✅ Pesanan berhasil dibuat!'),
                                  backgroundColor: Color(0xFF00AFC1),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cyan,
                            ),
                            child: const Text(
                              'Bayar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cyan,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Bayar Rp ${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, int price, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? null : Colors.grey[700],
          ),
        ),
        Text(
          'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? const Color(0xFF00AFC1) : null,
          ),
        ),
      ],
    );
  }
}
