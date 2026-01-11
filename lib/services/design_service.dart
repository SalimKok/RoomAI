import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class DesignService {
  static final DesignService _instance = DesignService._internal();
  factory DesignService() => _instance;
  DesignService._internal();

  Future<void> saveDesign({
    required File imageFile,
    required String style,
  }) async {
    try {
      List<int> imageBytes = await imageFile.readAsBytes();

      String base64Image = base64Encode(imageBytes);

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