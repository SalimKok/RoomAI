import 'package:flutter/material.dart';

import 'onboarding_screen_2.dart';

class DesignFeature {
  final String title;
  final String imagePath;

  DesignFeature({required this.title, required this.imagePath});
}

class OnboardingScreenOne extends StatelessWidget {
  OnboardingScreenOne({Key? key}) : super(key: key);

  final List<DesignFeature> features = [
    DesignFeature(
      title: "İç Mekan Tasarımı",
      imagePath: "assets/images/ic_mekan.png",
    ),
    DesignFeature(
      title: "Bahçe Tasarımı",
      imagePath: "assets/images/bahce.png",
    ),
    DesignFeature(
      title: "Balkon Tasarımı",
      imagePath: "assets/images/balkon.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return _ComparisonCard(feature: features[index]);
                  },
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardingScreenTwo(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF0000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Devam Et",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  final DesignFeature feature;

  const _ComparisonCard({Key? key, required this.feature}) : super(key: key);

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
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                feature.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) =>
                    const Center(child: Icon(Icons.image, color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
