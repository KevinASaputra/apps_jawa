import 'dart:ui';
import 'package:flutter/material.dart';

class StatCard extends StatefulWidget {
  final IconData icon;
  final String total;
  final String title;
  final Color color;
  final bool isDarkTop;

  const StatCard({
    super.key,
    required this.icon,
    required this.total,
    required this.title,
    required this.color,
    this.isDarkTop = false,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isPressed ? 0.97 : 1,
      duration: const Duration(milliseconds: 120),
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) {
          Future.delayed(const Duration(milliseconds: 120), () {
            setState(() => isPressed = false);
          });
        },

        // ==================== CARD ====================
        child: Container(
          width: 150,
          height: 115,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.6),
            boxShadow: [
              BoxShadow(
                color: Colors.black26.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 6),
              )
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1.2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),

              // ==================== ISI CARD ====================
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ICON BUBBLE
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color.withOpacity(0.15),
                      ),
                      child: Icon(
                        widget.icon,
                        size: 26,
                        color: widget.color,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // JUMLAH
                    Text(
                      widget.total,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),

                    // TITLE
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
