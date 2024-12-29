import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs; // State untuk halaman saat ini
  late PageController pageController;


  @override
  void onInit() {
    pageController = PageController(); // Inisialisasi PageController
    super.onInit();
  }

  void changePage(int index) {
    currentPage.value = index;
  }

  void goToNextPage() {
    if (currentPage.value < 2) { // 2 adalah index slide terakhir (0, 1, 2)
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

   void goToPreviousPage() {
    if (currentPage.value > 0) { // Pastikan tidak di slide pertama
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToHome() {
    Get.offAllNamed('/login'); // Ganti '/home' dengan route utama aplikasi Anda
  }

   @override
  void onClose() {
    pageController.dispose(); // Jangan lupa dispose controller
    super.onClose();
  }
}
