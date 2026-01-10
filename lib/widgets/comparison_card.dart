import 'package:flutter/material.dart';
import '../models/feature_item.dart';

class ComparisonCard extends StatelessWidget {
  final FeatureItem feature;

  const ComparisonCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          feature.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[900],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            feature.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => const Center(child: Icon(Icons.image, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}