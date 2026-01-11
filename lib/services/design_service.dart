import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class DesignService {
  static final DesignService _instance = DesignService._internal();
  factory DesignService() => _instance;
  DesignService._internal();

  Future<void> saveDesign({
    required File imageFile,
    required String style,
  }) async {
    try {
      Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        minWidth: 800,
        minHeight: 800,
        quality: 80,
      );

      if (compressedBytes == null) {
        throw Exception("Resim sıkıştırma başarısız oldu.");
      }

      String base64Image = base64Encode(compressedBytes);

      if (base64Image.length > 1000000) {
        throw Exception("Resim sıkıştırılmasına rağmen çok büyük! Daha düşük kalite seçmelisin.");
      }

      await FirebaseFirestore.instance.collection('designs').add({
        'title': "$style Oda",
        'subtitle': "Oluşturulma: ${DateTime.now().toString().substring(0, 10)}",
        'style': style,
        'badgeText': style,
        'imagePath': base64Image,
        'createdAt': FieldValue.serverTimestamp(),
      });

    } catch (e) {
      throw Exception("Kaydetme hatası: $e");
    }
  }
}