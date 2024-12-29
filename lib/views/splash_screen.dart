import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pembukuan_keuangan/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inisialisasi SplashController menggunakan GetX
    Get.put(SplashController());

    return Scaffold(
      body: Container(
        color: Colors.blue, // Warna latar belakang biru
        child: Center(
          child: Image.asset(
            'asset/Images/Splash_page.png', // Path ke logo
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
