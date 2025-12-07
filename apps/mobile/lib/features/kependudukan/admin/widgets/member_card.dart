import 'package:flutter/material.dart';

// =====================================================
// MEMBER CARD - For displaying family members
// =====================================================
class MemberCard extends StatelessWidget {
  final String name;
  final String nik;
  final String relation;
  final String age;
  final String gender;
  final VoidCallback? onTap;

  const MemberCard({
    super.key,
    required this.name,
    required this.nik,
    required this.relation,
    required this.age,
    required this.gender,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    IconData genderIcon = gender.toLowerCase() == "laki-laki" 
        ? Icons.male_outlined 
        : Icons.female_outlined;
    Color genderColor = gender.toLowerCase() == "laki-laki" 
        ? Colors.blue 
        : Colors.pink;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black.withOpacity(0.04),
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // AVATAR WITH GENDER ICON
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: genderColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(genderIcon, color: genderColor, size: 28),
            ),

            const SizedBox(width: 14),

            // MEMBER INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7F8FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          relation,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF00AFC1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "NIK: $nik",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.cake_outlined, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        age,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ARROW ICON
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
