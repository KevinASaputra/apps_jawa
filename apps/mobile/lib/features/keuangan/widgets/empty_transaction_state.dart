import 'package:flutter/material.dart';

/// Empty state untuk ketika tidak ada transaksi
class EmptyTransactionState extends StatelessWidget {
  final bool isPemasukan;

  const EmptyTransactionState({
    super.key,
    required this.isPemasukan,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(Icons.inbox_outlined, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              "Belum ada transaksi ${isPemasukan ? 'pemasukan' : 'pengeluaran'}",
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
