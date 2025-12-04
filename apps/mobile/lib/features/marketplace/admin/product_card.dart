import 'package:flutter/material.dart';
import 'small_tag.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String umkm;
  final String stok;
  final String rt;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.umkm,
    required this.stok,
    required this.rt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================== GAMBAR =====================
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              image,
              width: 95,
              height: 95,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 14),

          // ===================== KONTEN DI KANAN =====================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // STATUS TERSEDIA
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xffDFFFE8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Tersedia",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff22A068),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // JUDUL
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 4),

                // HARGA
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff0093C6),
                  ),
                ),

                const SizedBox(height: 6),

                // UMKM
                Text(
                  umkm,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey[700],
                  ),
                ),

                const SizedBox(height: 6),

                // TAG + STOK
                Row(
                  children: [
                    const SmallTag(text: "Pakaian"),
                    const SizedBox(width: 6),
                    SmallTag(text: rt),

                    const Spacer(),

                    Text(
                      "Stok: $stok",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ======================== TOMBOL LIHAT DETAIL ========================
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Placeholder(),
                        ),
                      );
                    },

                    child: _PressableButton(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PressableButton extends StatefulWidget {
  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        setState(() => isPressed = true);
      },
      onPointerUp: (_) {
        setState(() => isPressed = false);
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isPressed ? const Color(0xff0093C6) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xff0093C6),
            width: 1.4,
          ),
        ),
        child: Center(
          child: Text(
            "Lihat Detail",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isPressed ? Colors.white : const Color(0xff0093C6),
            ),
          ),
        ),
      ),
    );
  }
}
