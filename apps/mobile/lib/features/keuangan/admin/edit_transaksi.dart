// File: d:\Semester 5\PBL\apps_jawa\apps\mobile\lib\features\keuangan\admin\edit_transaksi.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/text_field.dart';
import '../../../models/dropdown_field.dart';
import 'keuangan_widgets.dart';

class EditTransaksiPage extends StatefulWidget {
  final Map<String, dynamic> transaksi;
  final bool isPemasukan;

  const EditTransaksiPage({
    super.key,
    required this.transaksi,
    required this.isPemasukan,
  });

  @override
  State<EditTransaksiPage> createState() => _EditTransaksiPageState();
}

class _EditTransaksiPageState extends State<EditTransaksiPage> {
  late TextEditingController _namaController;
  late TextEditingController _nominalController;
  late TextEditingController _tanggalController;
  late TextEditingController _sumberController;
  late TextEditingController _keteranganController;
  String? selectedKategori;

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
    _namaController = TextEditingController(text: widget.transaksi['nama']);
    _nominalController = TextEditingController(
        text: widget.transaksi['nominal'].toString());
    _tanggalController =
        TextEditingController(text: widget.transaksi['tanggal']);
    _sumberController = TextEditingController(
        text: widget.transaksi[widget.isPemasukan ? 'sumber' : 'penerima']);
    _keteranganController =
        TextEditingController(text: widget.transaksi['keterangan']);
    selectedKategori = widget.transaksi['kategori'];
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
        title: const Text("Edit Transaksi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
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
                              label: "",
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
                          items: widget.isPemasukan
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
                widget.isPemasukan ? "Sumber" : "Penerima",
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

              // Total Summary
              FormSummaryCard(
                isPemasukan: widget.isPemasukan,
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
                        side: const BorderSide(color: Colors.cyan, width: 2),
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
                        // Simpan perubahan
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Transaksi berhasil diperbarui"),
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
                        "Simpan Perubahan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}