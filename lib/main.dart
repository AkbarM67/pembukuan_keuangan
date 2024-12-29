import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pembukuan_keuangan/firebase_options.dart';
import 'package:pembukuan_keuangan/views/home_screen.dart';
import 'package:pembukuan_keuangan/views/add_record_screen.dart';
import 'package:pembukuan_keuangan/views/login_screen.dart';
import 'package:pembukuan_keuangan/views/onboarding_screen.dart';
import 'package:pembukuan_keuangan/views/register_screen.dart';
import 'package:pembukuan_keuangan/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dompet Swag',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/onboarding', page: () =>  OnboardingScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/add_record', page: () => AddRecordScreen()),
      ],
    );
  }
}
