import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi Daftar
  Future<void> register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Set nama pengguna
      await userCredential.user?.updateDisplayName(name);

      // Navigasi ke Home
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Gagal mendaftar");
    }
  }

  // Fungsi Login
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Navigasi ke Home
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Gagal masuk");
    }
  }

  // Fungsi Logout
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }

  // Mendapatkan Nama Pengguna
  String getUserName() {
    return _auth.currentUser?.displayName ?? "User";
  }
}
