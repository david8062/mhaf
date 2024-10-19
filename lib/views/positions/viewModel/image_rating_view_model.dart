import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageRatingViewModel extends ChangeNotifier {
  double _rating = 3.0;
  String imageUrl = '';
  String imageId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ImageRatingViewModel({required this.imageId});

  double get rating => _rating;

  // Función para obtener la URL de la imagen desde Firebase Storage
  Future<void> fetchImageUrl() async {
    String url = await FirebaseStorage.instance
        .ref('images/$imageId.jpg')
        .getDownloadURL();
    imageUrl = url;
    notifyListeners();
  }

  // Función para actualizar la calificación
  void updateRating(double newRating) {
    _rating = newRating;
    notifyListeners();
  }

  // Enviar la calificación a Firestore
  Future<void> submitRating(String userId) async {
    try {
      DocumentReference imageRef =
      _firestore.collection('images').doc(imageId);

      // Actualizar el subdocumento del usuario con su calificación
      await imageRef.collection('ratings').doc(userId).set({
        'rating': _rating,
      });

      // Leer la información actual de la imagen para actualizar el promedio
      DocumentSnapshot imageSnapshot = await imageRef.get();
      double averageRating = imageSnapshot['averageRating'] ?? 0;
      int totalRatings = imageSnapshot['totalRatings'] ?? 0;

      // Calcular el nuevo promedio
      double newAverageRating = ((averageRating * totalRatings) + _rating) /
          (totalRatings + 1);

      // Actualizar los datos de la imagen en Firestore
      await imageRef.update({
        'averageRating': newAverageRating,
        'totalRatings': totalRatings + 1,
      });

      print("Calificación enviada: $_rating");
    } catch (e) {
      print("Error al enviar la calificación: $e");
    }
  }
}
