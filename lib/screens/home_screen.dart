import 'package:flutter/material.dart';
import 'package:roomai/models/design_item.dart';
import 'package:roomai/screens/paywall_screen.dart';
import 'package:roomai/widgets/design_card.dart';
import 'package:roomai/screens/design_screen.dart';
import 'package:roomai/screens/profile_screen.dart';
import 'package:roomai/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<DesignItem> _designItems = [
    DesignItem(
      title: "Boş Oda Tasarımı",
      subtitle: "Boş odanızı yeniden tasarlayın.",
      badgeText: "Popüler",
      imagePath: "assets/images/ic_mekan.png",
    ),
    DesignItem(
      title: "Açık Alan Tasarımı",
      subtitle: "Bahçenizi ve açık alanınızı tasarlayın.",
      badgeText: "Önerilen",
      imagePath: "assets/images/bahce.png",
    ),
    DesignItem(
      title: "Dekorasyon Tasarımı",
      subtitle: "Dekorasyonunuzu ve odanızı düzenleyin.",
      badgeText: "Popüler",
      imagePath: "assets/images/img_8.png",
    ),
    DesignItem(
      title: "Dış Mekan Tasarımı",
      subtitle: "Dış mekanınızı yeniden tasarlayın.",
      badgeText: "Yeni",
      imagePath: "assets/images/balkon.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeBody(),
      const Scaffold(body: Center(child: Text("Keşfet"))),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Ana Sayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: "Keşfet"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profil"),
        ],
      ),
    );
  }

  Widget _buildHomeBody() {
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          children: [
            _buildBanner(),
            const SizedBox(height: 20),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _designItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final item = _designItems[index];
                return DesignCard(
                  item: item,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DesignScreen(title: item.title)),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFD4AF37), Color(0xFF8B6914)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(Icons.star, color: Colors.white.withOpacity(0.1), size: 150),
          ),
          const Positioned(
            left: 20, bottom: 50,
            child: Text(
                "Room Banana Pro",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)
            ),
          ),
          const Positioned(
            left: 20, bottom: 20,
            child: Text(
                "Standartları aşın...",
                style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500)
            ),
          ),
          Positioned(
            right: 16, bottom: 16,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text("Dene >", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}