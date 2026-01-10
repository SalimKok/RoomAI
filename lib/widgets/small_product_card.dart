import 'package:flutter/material.dart';

class SmallProductCard extends StatelessWidget {
  final String imagePath;

  const SmallProductCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}