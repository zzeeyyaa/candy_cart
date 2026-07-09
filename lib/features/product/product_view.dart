import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_controller.dart';
import '../auth/auth_controller.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    // Registrasi Controller
    final controller = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Candy Cart 🍬',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Keluar',
            onPressed: () {
              // Panggil controller auth untuk logout
              Get.find<AuthController>().signOut();
            },
          ),
        ],
      ),
      // Obx akan otomatis me-refresh UI jika isLoading atau products berubah
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: SpinKitDancingSquare(color: Colors.pinkAccent, size: 50.0),
          );
        }

        if (controller.products.isEmpty) {
          return const Center(child: Text('Yah, permennya habis 😢'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl ?? 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => const Center(child: SpinKitPulse(color: Colors.pinkAccent)),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '\$${product.price}',
                          style: GoogleFonts.poppins(color: Colors.pinkAccent, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}