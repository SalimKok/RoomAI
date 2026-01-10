import 'dart:io';
import 'package:flutter/material.dart';

class ImageUploadCard extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;

  const ImageUploadCard({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: image != null
              ? _buildSelectedImageState()
              : _buildEmptyState(),
        ),
      ),
    );
  }

  Widget _buildSelectedImageState() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.file(image!, fit: BoxFit.cover),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: const Row(
              children: [
                Icon(Icons.edit, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text("Değiştir", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add_a_photo_outlined, size: 40, color: Colors.orange.shade400),
        ),
        const SizedBox(height: 20),
        const Text("Fotoğraf Yükle", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        Text("veya kamerayı kullan", style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
      ],
    );
  }
}