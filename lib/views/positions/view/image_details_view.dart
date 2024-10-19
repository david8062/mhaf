import 'package:flutter/material.dart';

import '../../../styles/colors.dart';


class ImageDetailsView extends StatelessWidget {
  final String imageUrl;
  final String name;

  const ImageDetailsView({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    String imageName = Uri.decodeComponent(
      imageUrl.split('/').last.split('.').first,
    );
    return Scaffold(
      appBar: AppBar(title: Text(name)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                width: double.infinity,
                height: 250,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.imageDetails,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: double.infinity,
              height: 45.0,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: AppColors.secondaryColor
              ),
              alignment: Alignment.center,
              child: Text(
                imageName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColors
                ),
              ),
            ),
            const SizedBox(height: 100),
            const Row(
              children: [
                Text(
                  "Calificación:",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Icon(Icons.star, color: Colors.yellow),
              ],
            ),
          ],
        ),

    );
  }
}
