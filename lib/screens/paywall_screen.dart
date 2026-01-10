import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:roomai/screens/home_screen.dart';
import 'package:roomai/widgets/pricing_card.dart';

final selectedPlanProvider = StateProvider<String>((ref) => 'yearly');

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlan = ref.watch(selectedPlanProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/img_7.png', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.80)),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  ),
                ),
                const Spacer(flex: 1),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Hayalinizdeki yaşam\nalanına çok yakınsınız",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1.2),
                  ),
                ),
                const Spacer(flex: 2),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: PricingCard(
                          title: "Haftalık",
                          price: "TL199,99",
                          badgeText: "POPÜLER",
                          isSelected: selectedPlan == 'weekly',
                          onTap: () => ref.read(selectedPlanProvider.notifier).state = 'weekly',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PricingCard(
                          title: "Yıllık",
                          price: "TL1.999,99",
                          subPrice: "Haftalık TL41,67",
                          badgeText: "İndirim 81%",
                          isYearly: true,
                          isSelected: selectedPlan == 'yearly',
                          onTap: () => ref.read(selectedPlanProvider.notifier).state = 'yearly',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Otomatik yenilenebilir, istediğin zaman iptal edilebilir.",
                          style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
                Container(
                  width: double.infinity,
                  height: 56,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF0000).withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(),),);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF0000),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: const Text("Devam Et", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}