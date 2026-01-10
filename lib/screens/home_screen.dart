import 'package:flutter/material.dart';
import 'package:roomai/models/design_item.dart';
import 'package:roomai/widgets/design_card.dart';
import 'package:roomai/screens/design_screen.dart';
import 'package:roomai/screens/profile_screen.dart';

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
      const Scaffold(body: Center(child: Text("Keşfet"))), // Placeholder
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Keşfet"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }

  Widget _buildHomeBody() {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Room AI", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        children: [
                          Icon(Icons.monetization_on, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text("Abone Ol", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.menu, size: 28),
                  ],
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFFC7A006),
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFF654321)]),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 16, bottom: 50,
            child: Text("Room Banana Pro", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const Positioned(
            left: 16, bottom: 20,
            child: Text("Standartları aşın...", style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          Positioned(
            right: 16, bottom: 16,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("Dene >", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}