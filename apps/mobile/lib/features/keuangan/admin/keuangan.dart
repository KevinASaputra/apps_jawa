import 'package:flutter/material.dart';
import '../../../models/buttom_navbar.dart';
import 'package:intl/intl.dart';
import 'detail_transaksi.dart';
import 'tambah_transaksi.dart';
import 'keuangan_widgets.dart';

class KeuanganPage extends StatefulWidget {
  const KeuanganPage({super.key});

  @override
  State<KeuanganPage> createState() => _KeuanganPageState();
}

class _KeuanganPageState extends State<KeuanganPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedMonth = "Nov 2024";
  String selectedCategory = "Kategori";

  // Data dummy
  final List<Map<String, dynamic>> pemasukanList = [
    {
      'id': '1',
      'nama': 'Iuran Sampah November',
      'nominal': 2500000,
      'tanggal': '2024-11-25',
      'kategori': 'Iuran Warga',
      'sumber': 'Warga RT 03',
      'keterangan': 'Iuran sampah bulanan dari seluruh warga RT 03',
    },
  ];

  final List<Map<String, dynamic>> pengeluaranList = [
    {
      'id': '1',
      'nama': 'Pembelian Tenda',
      'nominal': 1500000,
      'tanggal': '2024-11-24',
      'kategori': 'Operasional',
      'penerima': 'Toko Perlengkapan',
      'keterangan': 'Pembelian tenda untuk kegiatan RT',
    },
  ];

  int get totalPemasukan =>
      pemasukanList.fold(0, (sum, item) => sum + (item['nominal'] as int));

  int get totalPengeluaran =>
      pengeluaranList.fold(0, (sum, item) => sum + (item['nominal'] as int));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Keuangan"),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.cyan,
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: Colors.cyan,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              tabs: const [
                Tab(text: "Pemasukan"),
                Tab(text: "Pengeluaran"),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPemasukanTab(),
                _buildPengeluaranTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahTransaksiPage(
                jenis: _tabController.index == 0 ? 'Pemasukan' : 'Pengeluaran',
              ),
            ),
          );
          if (result == true) {
            setState(() {});
          }
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildPemasukanTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Card Total Pemasukan
          TotalSummaryCard(
            isPemasukan: true,
            total: totalPemasukan,
          ),

          const SizedBox(height: 20),

          // Filter
          Row(
            children: [
              Expanded(
                child: _buildFilterButton(Icons.calendar_today, selectedMonth),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilterButton(Icons.filter_list, selectedCategory),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // List Transaksi
          if (pemasukanList.isEmpty)
            const EmptyTransactionState(isPemasukan: true)
          else
            ...pemasukanList.map((transaksi) =>
                _buildTransaksiCard(transaksi, isPemasukan: true)),
        ],
      ),
    );
  }

  Widget _buildPengeluaranTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Card Total Pengeluaran
          TotalSummaryCard(
            isPemasukan: false,
            total: totalPengeluaran,
          ),

          const SizedBox(height: 20),

          // Filter
          Row(
            children: [
              Expanded(
                child: _buildFilterButton(Icons.calendar_today, selectedMonth),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilterButton(Icons.filter_list, selectedCategory),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // List Transaksi
          if (pengeluaranList.isEmpty)
            const EmptyTransactionState(isPemasukan: false)
          else
            ...pengeluaranList.map((transaksi) =>
                _buildTransaksiCard(transaksi, isPemasukan: false)),
        ],
      ),
    );
  }

  Widget _buildFilterButton(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransaksiCard(Map<String, dynamic> transaksi,
      {required bool isPemasukan}) {
    final nominal = transaksi['nominal'] as int;
    final formattedNominal = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(nominal);

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailTransaksiPage(
              transaksi: transaksi,
              isPemasukan: isPemasukan,
            ),
          ),
        );
        if (result == true) {
          setState(() {});
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            // Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isPemasukan
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isPemasukan ? Icons.trending_up : Icons.trending_down,
                color: isPemasukan ? Colors.green : Colors.red,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaksi['nama'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF1E1E1E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transaksi['tanggal'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.cyan.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          transaksi['kategori'],
                          style: const TextStyle(
                            color: Colors.cyan,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "• ${transaksi[isPemasukan ? 'sumber' : 'penerima']}",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Nominal
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${isPemasukan ? '+' : '-'}Rp ${NumberFormat('#,###', 'id_ID').format(nominal / 1000)}K",
                  style: TextStyle(
                    color: isPemasukan ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
