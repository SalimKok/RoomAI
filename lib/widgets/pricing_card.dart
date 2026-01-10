import 'package:flutter/material.dart';

class PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String? subPrice;
  final String badgeText;
  final bool isSelected;
  final bool isYearly;
  final VoidCallback onTap;

  const PricingCard({
    super.key,
    required this.title,
    required this.price,
    this.subPrice,
    required this.badgeText,
    required this.isSelected,
    this.isYearly = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? const Color(0xFFFF0000) : Colors.white24;
    final double borderWidth = isSelected ? 2.0 : 1.0;

    final backgroundGradient = isSelected
        ? LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFFFF0000).withOpacity(0.2),
        Colors.black.withOpacity(0.6),
      ],
    )
        : LinearGradient(
      colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.6)],
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: const Color(0xFFFF0000),
                child: Text(
                  badgeText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isYearly) ...[
                          const Icon(Icons.auto_awesome, color: Color(0xFFFFD700), size: 22),
                          const SizedBox(height: 4),
                        ],
                        const SizedBox(width: 6),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      price,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    if (subPrice != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        subPrice!,
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}