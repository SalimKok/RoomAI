import 'package:flutter/material.dart';
import 'package:roomai/screens/paywall_screen.dart';
import 'package:roomai/widgets/custom_button.dart';
import 'package:roomai/widgets/small_product_card.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const _InputProductsSection(),

              const Expanded(flex: 2, child: _AIProcessingSection()),

              const Expanded(flex: 4, child: _ResultSection()),

              const SizedBox(height: 30),

              const _FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputProductsSection extends StatelessWidget {
  const _InputProductsSection();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmallProductCard(imagePath: 'assets/images/product_1.png'),
        SmallProductCard(imagePath: 'assets/images/product_2.png'),
        SmallProductCard(imagePath: 'assets/images/product_3.png'),
      ],
    );
  }
}

class _AIProcessingSection extends StatelessWidget {
  const _AIProcessingSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.arrow_downward_rounded, color: Colors.white54, size: 32),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("🍌", style: TextStyle(fontSize: 20)),
              SizedBox(width: 8),
              Text(
                "NANO BANANA",
                style: TextStyle(
                  color: Color(0xFFFFD700),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Icon(Icons.arrow_downward_rounded, color: Colors.white54, size: 32),
      ],
    );
  }
}

class _ResultSection extends StatelessWidget {
  const _ResultSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/images/result_room.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Ürün görselleriyle hayalinizdeki odaları baştan yaratın",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),

        CustomButton(
          text: "Devam Et",
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PaywallScreen()),
            );
          },
        ),
      ],
    );
  }
}