import 'package:flutter/material.dart';

class FilterCategory extends StatelessWidget {
  final List<String> items;
  final int selectedIndex;
  final Function(int) onSelected;

  const FilterCategory({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          bool active = selectedIndex == index;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: active ? Colors.brown : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black26),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : [],
              ),
              child: Text(
                items[index],
                style: TextStyle(
                  color: active ? Colors.white : Colors.black87,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
