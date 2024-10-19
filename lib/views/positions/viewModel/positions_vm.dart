import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/image_details.dart'; // Importar el modelo de ImageDetails

class PositionsVm extends ChangeNotifier {
  bool _isLoading = true;
  String? _errorMessage;
  List<ImageDetails> _images = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ImageDetails> get images => _images;

  Future<void> fetchImages(String gender) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      String folderName;

      switch (gender) {
        case '1':
          folderName = 'Hetero';
          break;
        case '2':
          folderName = 'Homo';
          break;
        default:
          folderName = 'Hetero';
          break;
      }

      final ListResult result = await FirebaseStorage.instance.ref(folderName).listAll();
      _images = await Future.wait(result.items.map((Reference ref) async {
        // Obtener la URL de la imagen
        String imageUrl = await ref.getDownloadURL();
        
        // Obtener los metadatos de la imagen
        FullMetadata metadata = await ref.getMetadata();
        
        // Crear una instancia de ImageDetails con los datos necesarios
        return ImageDetails(
          imageUrl: imageUrl,
          name: metadata.name,
          contentType: metadata.contentType ?? 'unknown',
          size: metadata.size ?? 0,
        );
      }).toList());

    } catch (error) {
      _errorMessage = 'Error loading images';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
