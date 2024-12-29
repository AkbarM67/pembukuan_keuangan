import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  final OnboardingController onboardingController = Get.put(OnboardingController());

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'asset/Images/Onboarding.png',
      'title': 'Aktivitas Pencatatan Uang Praktis',
      'description':
          'Pantau dan kelola keuangan Anda dengan mudah berkat fitur pencatatan keuangan praktis kami yang memungkinkan Anda merekam transaksi dengan cepat dan efisien.'
    },
    {
      'image': 'asset/Images/Onboarding2.png',
      'title': 'Mode Grafik Interaktif',
      'description':
          'Temukan perjalanan keuangan Anda secara visual dengan grafik intuitif kami, sehingga lebih mudah untuk melacak dan memahami kebiasaan pengeluaran Anda.'
    },
    {
      'image': 'asset/Images/Onboarding3.png',
      'title': 'Ayo Bergerak Bersama!',
      'description':
          'Semua bisa profesional dalam mengatur keuangan, tidak perlu pengalaman dan mudah untuk pemula.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // PageView untuk konten onboarding
          Expanded(
            child: PageView.builder(
              controller: onboardingController.pageController,
              onPageChanged: onboardingController.changePage,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      data['image']!,
                      width: size.width,
                      height: size.height * 0.5,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      data['title']!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        data['description']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Indikator halaman
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: onboardingController.currentPage.value == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: onboardingController.currentPage.value == index
                        ? Colors.blue
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Tombol Lanjutkan
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: size.width * 0.6,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  final isLastPage =
                      onboardingController.currentPage.value == onboardingData.length - 1;

                  if (isLastPage) {
                    onboardingController.skipToHome();
                  } else {
                    onboardingController.goToNextPage();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Lanjutkan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Tombol Lewati
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: TextButton(
              onPressed: onboardingController.skipToHome,
              child: const Text(
                'Lewati',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
