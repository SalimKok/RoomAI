import 'package:flutter/material.dart';

class StyleSelector extends StatelessWidget {
  final List<String> styles;
  final int selectedIndex;
  final Function(int) onStyleSelected;

  const StyleSelector({
    super.key,
    required this.styles,
    required this.selectedIndex,
    required this.onStyleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tasarım Stili", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 15),
        SizedBox(
          height: 55,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: styles.length,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => onStyleSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF2D2D2D) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade200),
                    boxShadow: isSelected
                        ? [BoxShadow(color: const Color(0xFF2D2D2D).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      styles[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}