import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// STATE: Seçilen planı tutan değişken (Varsayılan: Yıllık 'yearly')
final selectedPlanProvider = StateProvider<String>((ref) => 'yearly');

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Seçili planı dinliyoruz (State değişince ekran yenilenir)
    final selectedPlan = ref.watch(selectedPlanProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. ARKAPLAN RESMİ (Bulanık Oda)
          Image.asset(
            'assets/images/img_7.png', // Senin oda resmin
            fit: BoxFit.cover,
          ),

          // 2. SİYAH FİLTRE (Resmi karartmak için)
          Container(color: Colors.black.withOpacity(0.80)),

          // 3. İÇERİK
          SafeArea(
            child: Column(
              children: [
                // KAPAT BUTONU (Sol Üst)
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  ),
                ),

                const Spacer(flex: 1), // Üstten biraz boşluk bırak

                // BAŞLIK
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Hayalinizdeki yaşam\nalanına çok yakınsınız",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),

                const Spacer(flex: 2), // Başlık ile kartlar arası boşluk

                // --- FİYAT KARTLARI (ANA KISIM) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // HAFTALIK KART
                      Expanded(
                        child: _PricingCard(
                          title: "Haftalık",
                          price: "TL199,99",
                          badgeText: "POPÜLER",
                          isSelected: selectedPlan == 'weekly',
                          onTap: () => ref.read(selectedPlanProvider.notifier).state = 'weekly',
                        ),
                      ),

                      const SizedBox(width: 16), // İki kart arası boşluk

                      // YILLIK KART
                      Expanded(
                        child: _PricingCard(
                          title: "Yıllık",
                          price: "TL1.999,99",
                          subPrice: "Haftalık TL41,67",
                          badgeText: "İndirim 81%",
                          isYearly: true, // Yıldız ikonu için
                          isSelected: selectedPlan == 'yearly',
                          onTap: () => ref.read(selectedPlanProvider.notifier).state = 'yearly',
                        ),
                      ),
                    ],
                  ),
                ),
                // -----------------------------------

                const SizedBox(height: 20),

                // BİLGİLENDİRME YAZISI (Check iconlu)
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

                // DEVAM ET BUTONU
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
                      print("Seçilen Plan: $selectedPlan");
                      // Buradan sonra Anasayfaya geçiş yapılacak
                      // Navigator.pushReplacement(...)
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF0000), // Pera Kırmızısı
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Devam Et",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // GÜVENLİK İKONU
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.lock, color: Colors.grey, size: 12),
                    SizedBox(width: 4),
                    Text(
                      "App Store ile Güvence Altında",
                      style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ALT LİNKLER
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _FooterLink("Satın Alımları Geri Yükle"),
                      _FooterLink("Gizlilik Politikası"),
                      _FooterLink("Kullanım Koşulları"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- YARDIMCI WIDGET: FİYAT KARTI ---
// Bu widget sayesinde iki kartı tekrar tekrar yazmıyoruz.
class _PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String? subPrice;
  final String badgeText;
  final bool isSelected;
  final bool isYearly;
  final VoidCallback onTap;

  const _PricingCard({
    required this.title,
    required this.price,
    this.subPrice,
    required this.badgeText,
    required this.isSelected,
    this.isYearly = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Renk Ayarları
    final borderColor = isSelected ? const Color(0xFFFF0000) : Colors.white24;
    final double borderWidth = isSelected ? 2.0 : 1.0;

    // Gradient Arkaplan (Sadece seçiliyse hafif kırmızımsı, değilse siyah)
    final backgroundGradient = isSelected
        ? LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFFFF0000).withOpacity(0.2), // Üstte hafif kırmızı
        Colors.black.withOpacity(0.6), // Altta koyu
      ],
    )
        : LinearGradient(
      colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.6)],
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220, // SABİT YÜKSEKLİK: Bu sayede ikisi de milimetrik eşit olur.
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        // ClipRRect: İçerik taşarsa köşeleri yuvarla
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              // 1. KIRMIZI BAŞLIK (Badge)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: const Color(0xFFFF0000), // Başlık hep kırmızı
                child: Text(
                  badgeText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // 2. KART İÇERİĞİ (Geri kalan boşluğu doldurur)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isYearly) ...[
                          // Yıllık planda yıldız ikonu
                          const Icon(Icons.auto_awesome, color: Color(0xFFFFD700), size: 22),
                          const SizedBox(height: 4),
                        ],
                      const SizedBox(width: 6),
                        Text(
                          title, // "Haftalık" veya "Yıllık"
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      price, // Fiyat
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    if (subPrice != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        subPrice!, // Alt metin
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Alt Linkler için küçük widget
class _FooterLink extends StatelessWidget {
  final String text;
  const _FooterLink(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold, // Altı çizili
      ),
    );
  }
}