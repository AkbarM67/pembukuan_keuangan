import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pembukuan_keuangan/views/Home_screen.dart';

class RegisterScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),

            // Icon di atas
            Center(
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'asset/Icon_login.png', // Ganti dengan path gambar Anda
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Daftar Sekarang Text
            Text(
              "Daftar Sekarang",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Masukkan data diri anda untuk menikmati fitur kami.",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 32),

            // Input Nama
            TextField(
              controller: nameController,
              focusNode: passwordFocus,
              onSubmitted: (_) {
                passwordFocus.unfocus(); // Sembunyikan keyboard
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Nama",
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 211, 211),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Input Email
            TextField(
              controller: emailController,
              focusNode: emailFocus,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "name@mail.com",
                hintStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 211, 211),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Input Password
            TextField(
              controller: passwordController,
              focusNode: passwordFocus,
              onSubmitted: (_) {
                passwordFocus.unfocus(); // Sembunyikan keyboard
              },
              obscureText: true,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Masukkan Password",
                hintStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 211, 211),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 24),

            // Tombol Daftar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                // Ambil nama dari TextField
                    String name = nameController.text.trim();
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim(); // Tambahkan controller untuk field nama

                    // Pastikan nama tidak kosong
                    if (name.isEmpty || email.isEmpty || password.isEmpty) {
                      Get.snackbar(
                          "Error",
                          "Semua data harus diisi",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                  } 
                  try {
                      // Firebase Authentication
                      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                       // Update nama pengguna di Firebase
                       await userCredential.user!.updateDisplayName(name);
                      Get.snackbar(
                        "Pendaftaran Berhasil",
                        "Silakan login untuk melanjutkan",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );

                      Get.toNamed('/login');
                } catch (e) {
                    Get.snackbar(
                      "Error",
                      e.toString(),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
              },
              child: Text(
                "Daftar",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 16),

            // Atau
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "atau",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 16),

            // Tombol Daftar Dengan Google
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Aksi saat tombol daftar dengan Google ditekan
              },
              icon: Image.asset(
                'asset/flat-color-icons_google.png', // Ganti dengan path gambar Google Anda
                height: 24,
                width: 24,
              ),
              label: Text(
                "Daftar Dengan Google",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),

            Spacer(),

            // Sudah punya akun? Masuk Sekarang
            Center(
              child: Text.rich(
                TextSpan(
                  text: "Sudah punya akun? ",
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: "Masuk Sekarang",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed('/login'); // Navigasi ke layar login
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
