import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToOnboarding();
  }
  void navigateToOnboarding() async {
    await Future.delayed(Duration(seconds: 10));
    Get.offNamed('/onboarding');
  }
}