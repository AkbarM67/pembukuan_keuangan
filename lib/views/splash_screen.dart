import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pembukuan_keuangan/controllers/splash_controller.dart';


class SplashScreen extends StatelessWidget{
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue, // Warna latar belakang biru
        child: Center(
          child: Image.asset(
            'asset/Images/Splash_page.png', // Path ke logo
          ),
        ),
      ),
    );
  }
}