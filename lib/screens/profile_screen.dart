import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomai/models/design_item.dart';
import 'package:roomai/screens/paywall_screen.dart';
import 'package:roomai/widgets/design_card.dart';
import 'package:roomai/widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      appBar: CustomAppBar(
        title: "Room AI",
        showProBadge: true,
        onProTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaywallScreen()),
          );
        },
        onSettingsTap: () {
          debugPrint("Menü tıklandı");
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15),
              child: const Text("Koleksiyonum", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('designs')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return const Center(child: Text("Hata oluştu."));
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return _buildEmptyState();
                  }

                  final data = snapshot.data!.docs;

                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      final doc = data[index];
                      final item = DesignItem(
                        title: doc['title'],
                        subtitle: doc['subtitle'],
                        imagePath: doc['imagePath'],
                        badgeText: doc['badgeText'],
                      );

                      return DesignCard(item: item, onTap: () {});
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported_outlined, size: 50, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text("Henüz tasarımın yok", style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}