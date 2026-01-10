import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roomai/widgets/image_upload_card.dart';
import 'package:roomai/widgets/style_selector.dart';
import 'package:roomai/widgets/gradient_button.dart';

class DesignScreen extends StatefulWidget {
  final String title;
  const DesignScreen({super.key, required this.title});

  @override
  State<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  int selectedStyleIndex = 0;
  final List<String> styles = ["Modern", "İskandinav", "Klasik", "Bohem", "Minimalist"];

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _checkPermissionAndPick(ImageSource source) async {
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      if (Platform.isAndroid) {
        status = await Permission.storage.request();
        if (status.isDenied) status = await Permission.photos.request();
      } else {
        status = await Permission.photos.request();
      }
    }

    if (status.isGranted) {
      _pickImage(source);
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Bu özellik için izin vermeniz gerekiyor.")),
        );
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 80);
      if (pickedFile != null) {
        setState(() => _selectedImage = File(pickedFile.path));
      }
    } catch (e) {
      debugPrint("Hata: $e");
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("İzin Gerekli"),
        content: const Text("Devam etmek için Ayarlar'dan izin vermelisiniz."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("İptal")),
          TextButton(onPressed: () { Navigator.pop(context); openAppSettings(); }, child: const Text("Ayarlar")),
        ],
      ),
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.orange.shade50, shape: BoxShape.circle),
                    child: const Icon(Icons.photo_library, color: Colors.orange),
                  ),
                  title: const Text("Galeriden Seç", style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () { Navigator.pop(context); _checkPermissionAndPick(ImageSource.gallery); },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt, color: Colors.blue),
                  ),
                  title: const Text("Kamera ile Çek", style: TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () { Navigator.pop(context); _checkPermissionAndPick(ImageSource.camera); },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hayalindeki Odayı Tasarla",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black87),
            ),
            const SizedBox(height: 5),
            Text(
              "Fotoğrafını yükle ve yapay zekanın sihrini izle.",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5),
            ),
            const SizedBox(height: 30),

            ImageUploadCard(
              image: _selectedImage,
              onTap: _showImageSourceDialog,
            ),

            const SizedBox(height: 35),

            StyleSelector(
              styles: styles,
              selectedIndex: selectedStyleIndex,
              onStyleSelected: (index) {
                setState(() => selectedStyleIndex = index);
              },
            ),
            const SizedBox(height: 40),

            GradientButton(
              text: "Sihri Başlat",
              onPressed: () {
                if (_selectedImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Lütfen önce bir fotoğraf yükleyin!"), backgroundColor: Colors.redAccent),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${styles[selectedStyleIndex]} stilinde tasarlanıyor..."), backgroundColor: Colors.green),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}