import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Card untuk menampilkan total di form tambah/edit transaksi
class FormSummaryCard extends StatelessWidget {
  final bool isPemasukan;
  final int nominal;

  const FormSummaryCard({
    super.key,
    required this.isPemasukan,
    required this.nominal,
  });

  @override
  Widget build(BuildContext context) {
    final formattedNominal = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(nominal);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isPemasukan
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPemasukan
              ? Colors.green.withOpacity(0.3)
              : Colors.red.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Total ${isPemasukan ? 'Pemasukan' : 'Pengeluaran'}",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "${isPemasukan ? '+' : '-'} $formattedNominal",
            style: TextStyle(
              color: isPemasukan ? Colors.green : Colors.red,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
