import 'package:flutter/material.dart';
import 'package:roomai/screens/onboarding_screen_1.dart';
import 'package:roomai/widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final List<String> myImages = [
      'assets/images/img.png', 'assets/images/img_2.png', 'assets/images/img_3.png',
      'assets/images/img_4.png', 'assets/images/img_5.png', 'assets/images/img_6.png',
      'assets/images/img_7.png', 'assets/images/img_8.png', 'assets/images/img.png',
      'assets/images/img_2.png','assets/images/img_3.png', 'assets/images/img_4.png',
      'assets/images/img_5.png', 'assets/images/img_6.png', 'assets/images/img_7.png',
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Column(children: _buildColumnList(myImages, 0, 3))),
                  const SizedBox(width: 10),
                  Expanded(child: Column(children: _buildColumnList(myImages, 1, 3))),
                  const SizedBox(width: 10),
                  Expanded(child: Column(children: _buildColumnList(myImages, 2, 3))),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0, left: 0, right: 0, height: screenSize.height * 0.6,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8), Colors.black],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 40, left: 20, right: 20,
            child: Column(
              children: [
                const Text(
                  "Roomy AI Bir Yaşam Alanı!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2),
                ),
                const SizedBox(height: 16),
                Text(
                  "Yaratıcılığınızı keşfedin, hayallerinizi güvenli ve kolay bir şekilde gerçeğe dönüştürün!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8), height: 1.4),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: "Başla",
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreenOne()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildColumnList(List<String> images, int startIndex, int jump) {
    List<Widget> list = [];
    for (int i = startIndex; i < images.length; i += jump) {
      list.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(images[i], fit: BoxFit.fitWidth),
          ),
        ),
      );
    }
    return list;
  }
}