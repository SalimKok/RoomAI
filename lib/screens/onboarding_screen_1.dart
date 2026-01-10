import 'package:flutter/material.dart';
import 'package:roomai/models/feature_item.dart';
import 'package:roomai/widgets/comparison_card.dart';
import 'package:roomai/widgets/custom_button.dart';
import 'onboarding_screen_2.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FeatureItem> features = [
      FeatureItem(title: "İç Mekan Tasarımı", imagePath: "assets/images/ic_mekan.png"),
      FeatureItem(title: "Bahçe Tasarımı", imagePath: "assets/images/bahce.png"),
      FeatureItem(title: "Balkon Tasarımı", imagePath: "assets/images/balkon.png"),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Boş Alanları Şahane\nMekanlara Dönüştürün",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: ListView.separated(
                  itemCount: features.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return ComparisonCard(feature: features[index]);
                  },
                ),
              ),

              const SizedBox(height: 20),

              CustomButton(
                text: "Devam Et",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const OnboardingScreenTwo()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}