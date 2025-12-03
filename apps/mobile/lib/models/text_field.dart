import 'package:flutter/material.dart';

class ModernTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final bool obscure;
  final Widget? suffix;
  final Widget? prefix;
  final IconData? prefixIcon;
  

  const ModernTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.obscure = false,
    this.suffix,
    this.prefix,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final cyan = Colors.cyan[600];

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Material(
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          cursorColor: cyan,
          decoration: InputDecoration(

            /// ⬇⬇ label berubah menjadi Row, icon + label
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null)
                  Icon(prefixIcon, size: 18, color: cyan),
                if (prefixIcon != null)
                  const SizedBox(width: 6),
                Text(label),
              ],
            ),

            floatingLabelBehavior: FloatingLabelBehavior.auto,

            floatingLabelStyle: TextStyle(
              color: cyan,
              fontWeight: FontWeight.w600,
            ),

            labelStyle: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),

            filled: true,
            fillColor: Colors.white,

            prefixIcon: prefix,
            suffixIcon: suffix,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cyan!, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
