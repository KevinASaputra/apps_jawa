import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? selected;
  final Function(DateTime) onSelected;
  final IconData icon;

  const DatePickerField({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.icon = Icons.calendar_today,
  });

  @override
  Widget build(BuildContext context) {
    final cyan = Colors.cyan[600];
    final dateText =
        selected == null ? "" : DateFormat("dd MMMM yyyy").format(selected!);

    return InkWell(
      onTap: () async {
        final pick = await showDatePicker(
          context: context,
          initialDate: selected ?? DateTime(2000),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          helpText: "Pilih Tanggal",
        );

        if (pick != null) {
          onSelected(pick);
        }
      },
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text(
                    dateText.isEmpty ? "Pilih tanggal" : dateText,
                    style: TextStyle(
                      color: dateText.isEmpty ? Colors.grey[500] : cyan,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.date_range_rounded,
                color: cyan, size: 22),
          ],
        ),
      ),
    );
  }
}
