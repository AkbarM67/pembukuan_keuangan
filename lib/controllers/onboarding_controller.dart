import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  void changePage(int index) {
    currentPage.value = index;
  }

  void goToNextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToHome() {
    Get.offAllNamed('/login'); // Ganti dengan route utama aplikasi Anda
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
