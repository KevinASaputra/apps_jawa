import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final IconData? icon; // <-- Tambah variabel icon

  const DropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.icon, // <-- terima icon di sini
  });

  @override
  Widget build(BuildContext context) {
    final cyan = Colors.cyan[600];

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,

        decoration: InputDecoration(
          border: InputBorder.none,

          // ⬇⬇ Label + Icon tampil bersama
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(icon, size: 18, color: cyan),
              if (icon != null) const SizedBox(width: 6),
              Text(label),
            ],
          ),
        ),

        icon: Icon(Icons.keyboard_arrow_down_rounded, color: cyan),

        items: items
            .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),

        onChanged: onChanged,
      ),
    );
  }
}
