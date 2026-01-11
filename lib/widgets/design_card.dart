import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/design_item.dart';

class DesignCard extends StatelessWidget {
  final DesignItem item;
  final VoidCallback onTap;

  const DesignCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Stack(
                  children: [
                    Container(color: Colors.grey.shade200),

                    Positioned.fill(
                      child: _buildImage(),
                    ),

                    if (item.badgeText != null)
                      Positioned(
                        top: 10,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                          ),
                          child: Text(
                            item.badgeText!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              if (item.subtitle.isNotEmpty)
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (item.imagePath.startsWith('http')) {
      return Image.network(
        item.imagePath,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => const Center(child: Icon(Icons.broken_image)),
      );
    }

    else if (item.imagePath.startsWith('assets')) {
      return Image.asset(
        item.imagePath,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => const Center(child: Icon(Icons.error)),
      );
    }

    else {
      try {
        return Image.memory(
          base64Decode(item.imagePath),
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) => const Center(child: Icon(Icons.broken_image)),
        );
      } catch (e) {
        return const Center(child: Icon(Icons.error));
      }
    }
  }
}