# RoomAI 🏠✨

**RoomAI**, kullanıcıların yaşam alanlarının fotoğraflarını yükleyip, seçtikleri mimari tarza (Modern, İskandinav, Bohem vb.) göre yapay zeka ile yeniden tasarlayabildikleri bir mobil uygulamadır.

## 📱 Ekran Görüntüleri
<img width="466" height="986" alt="image" src="https://github.com/user-attachments/assets/b37bacc9-1782-4ab8-80d8-865e33aff01a" />
<img width="470" height="989" alt="image" src="https://github.com/user-attachments/assets/0d180a25-5b10-4702-b608-2cb9152c79af" />
<img width="461" height="993" alt="image" src="https://github.com/user-attachments/assets/9a291f50-ba7a-46f7-bc43-07976abd801c" />

## 🚀 Özellikler

* **Gelişmiş Durum Yönetimi:** Riverpod ile akıcı ve hatasız uygulama akışı.
* **Fotoğraf Yükleme:** Kamera veya galeriden kolayca fotoğraf seçimi.
* **Görüntü Optimizasyonu:** Yüksek performans için `flutter_image_compress` ile sıkıştırma.
* **Bulut Entegrasyonu:** Firebase Firestore ve Storage ile güvenli veri/dosya saklama.
* **Modern UI:** Kullanıcı dostu arayüz ve yumuşak geçişler.

## 🛠 Kullanılan Teknolojiler ve Paketler

Bu proje **Flutter** ile geliştirilmiş olup, aşağıdaki temel paketleri kullanmaktadır:

* **State Management (Durum Yönetimi):**
  * [`flutter_riverpod`]: Uygulama genelinde reaktif durum yönetimi.

* **Backend (Firebase):**
  * `firebase_core`: Firebase başlatma ve yapılandırma.
  * `cloud_firestore`: Tasarım verilerinin veritabanında saklanması.
  * `firebase_storage`: Yüksek boyutlu resim dosyalarının depolanması.

* **Medya ve Dosya İşlemleri:**
  * `image_picker`: Galeri ve kameradan fotoğraf seçimi.
  * `flutter_image_compress`: Resim boyutlarını küçülterek performans artırma.

* **Yardımcı Araçlar:**
  * `permission_handler`: Kamera ve galeri izinlerinin yönetimi.
  * `cupertino_icons`: iOS uyumlu ikon setleri.

