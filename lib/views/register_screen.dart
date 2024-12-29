import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            const SizedBox(height: 50),

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
            const SizedBox(height: 20),

            // Daftar Sekarang Text
            const Text(
              "Daftar Sekarang",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Masukkan data diri anda untuk menikmati fitur kami.",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),

            // Input Nama
            TextField(
              controller: nameController,
              focusNode: passwordFocus,
              onSubmitted: (_) {
                passwordFocus.unfocus(); // Sembunyikan keyboard
              },
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Nama",
                labelStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 211, 211),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Input Email
            TextField(
              controller: emailController,
              focusNode: emailFocus,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "name@mail.com",
                hintStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 211, 211),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Input Password
            TextField(
              controller: passwordController,
              focusNode: passwordFocus,
              onSubmitted: (_) {
                passwordFocus.unfocus(); // Sembunyikan keyboard
              },
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Masukkan Password",
                hintStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 211, 211),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Daftar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                String name = nameController.text.trim();
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

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
              child: const Text(
                "Daftar",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Atau
            Row(
              children: [
                const Expanded(child: Divider(color: Colors.grey)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "atau",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Expanded(child: Divider(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),

            // Tombol Daftar Dengan Google
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
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
              label: const Text(
                "Daftar Dengan Google",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(),

            // Sudah punya akun? Masuk Sekarang
            Center(
              child: Text.rich(
                TextSpan(
                  text: "Sudah punya akun? ",
                  style: const TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: "Masuk Sekarang",
                      style: const TextStyle(
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
