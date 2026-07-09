import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'login_view.dart';
import '../product/product_view.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Put controller in memory so it listens immediately
    final authController = Get.put(AuthController());

    return Obx(() {
      if (authController.currentUser.value == null) {
        return const LoginView();
      } else {
        return const ProductView();
      }
    });
  }
}
