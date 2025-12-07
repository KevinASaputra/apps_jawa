// File: d:\Semester 5\PBL\apps_jawa\apps\mobile\lib\features\keuangan\admin\tambah_transaksi.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/text_field.dart';
import '../../../models/dropdown_field.dart';
import 'keuangan_widgets.dart';

class TambahTransaksiPage extends StatefulWidget {
  final String jenis;

  const TambahTransaksiPage({
    super.key,
    required this.jenis,
  });

  @override
  State<TambahTransaksiPage> createState() => _TambahTransaksiPageState();
}

class _TambahTransaksiPageState extends State<TambahTransaksiPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _sumberController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  String? selectedKategori;
  String selectedJenis = 'Pemasukan';

  final List<String> kategoriPemasukan = [
    'Iuran Warga',
    'Donasi',
    'Bantuan Pemerintah',
    'Lainnya'
  ];

  final List<String> kategoriPengeluaran = [
    'Operasional',
    'Kegiatan RT',
    'Pembangunan',
    'Kebersihan',
    'Keamanan',
    'Lainnya'
  ];

  @override
  void initState() {
    super.initState();
    selectedJenis = widget.jenis;
    _tanggalController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nominalController.dispose();
    _tanggalController.dispose();
    _sumberController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPemasukan = selectedJenis == 'Pemasukan';
    final nominal = int.tryParse(_nominalController.text) ?? 0;
    final formattedNominal = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(nominal);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Tambah Pemasukan"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Jenis Transaksi Selector
            Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(4),
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
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedJenis = 'Pemasukan';
                          selectedKategori = null;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isPemasukan
                              ? Colors.green
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: isPemasukan ? Colors.white : Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Pemasukan",
                              style: TextStyle(
                                color:
                                    isPemasukan ? Colors.white : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedJenis = 'Pengeluaran';
                          selectedKategori = null;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color:
                              !isPemasukan ? Colors.red : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.trending_down,
                              color: !isPemasukan ? Colors.white : Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Pengeluaran",
                              style: TextStyle(
                                color:
                                    !isPemasukan ? Colors.white : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Detail Transaksi",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Nama Transaksi
                  const Text(
                    "Nama Transaksi *",
                    style: TextStyle(
                      color: Color(0xFF8B4513),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ModernTextField(
                    controller: _namaController,
                    label: "Contoh: Iuran Bulanan Desember",
                  ),

                  // Nominal
                  const Text(
                    "Nominal *",
                    style: TextStyle(
                      color: Color(0xFF8B4513),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ModernTextField(
                    controller: _nominalController,
                    label: "Rp  0",
                    keyboardType: TextInputType.number,
                    prefix: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Rp",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Tanggal dan Kategori
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Tanggal *",
                              style: TextStyle(
                                color: Color(0xFF8B4513),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _tanggalController.text =
                                        DateFormat('dd/MM/yyyy').format(picked);
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                child: ModernTextField(
                                  controller: _tanggalController,
                                  label: "Pilih Tanggal",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Kategori *",
                              style: TextStyle(
                                color: Color(0xFF8B4513),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            DropdownField(
                              label: "Pilih",
                              value: selectedKategori,
                              items: isPemasukan
                                  ? kategoriPemasukan
                                  : kategoriPengeluaran,
                              onChanged: (value) {
                                setState(() {
                                  selectedKategori = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Sumber/Penerima
                  Text(
                    isPemasukan ? "Sumber" : "Penerima",
                    style: const TextStyle(
                      color: Color(0xFF8B4513),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ModernTextField(
                    controller: _sumberController,
                    label: "Dari siapa/mana",
                  ),

                  // Keterangan
                  const Text(
                    "Keterangan",
                    style: TextStyle(
                      color: Color(0xFF8B4513),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextField(
                      controller: _keteranganController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Deskripsi transaksi...",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        contentPadding: const EdgeInsets.all(16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Total Summary (scrolls with content)
                  FormSummaryCard(
                    isPemasukan: isPemasukan,
                    nominal: nominal,
                  ),

                  const SizedBox(height: 32),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.cyan,
                            side:
                                const BorderSide(color: Colors.cyan, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Batal",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Validasi dan simpan
                            if (_namaController.text.isEmpty ||
                                _nominalController.text.isEmpty ||
                                selectedKategori == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Mohon lengkapi semua field yang wajib diisi"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Transaksi berhasil ditambahkan"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context, true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Tambah Transaksi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}