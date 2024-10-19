import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/drawer.dart';
import '../model/image_details.dart';
import '../viewModel/positions_vm.dart';
import '../../../styles/colors.dart';
import 'image_details_view.dart';

class PositionsView extends StatelessWidget {
  final String gender;
  const PositionsView({super.key, required this.gender});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PositionsVm()..fetchImages(gender),
      child: Scaffold(
        drawer: const Drawe(),
        body: Consumer<PositionsVm>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.errorMessage != null) {
              return Center(child: Text(viewModel.errorMessage!));
            } else if (viewModel.images.isEmpty) {
              return const Center(child: Text("No se encontraron imagenes"));
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemCount: viewModel.images.length,
                itemBuilder: (context, index) {
                  ImageDetails imageDetails = viewModel.images[index];
                  String imageUrl = imageDetails.imageUrl;
                  String name = imageDetails.name;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageDetailsView(imageUrl: imageUrl, name: name),
                        ),
                      );
                    },
                    child: Container(
                      width: 70.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.image1.withOpacity(0.20),
                            AppColors.image2.withOpacity(0.20)
                          ],
                          stops: const [0.50, 1.0], // Porcentaje de cada color
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Column(
                          children: [
                            Image.network(
                              imageDetails.imageUrl,
                              fit: BoxFit.cover,
                            ),                            
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
