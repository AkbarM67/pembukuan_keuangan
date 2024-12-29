import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRecordController extends GetxController {
  var isIncome = true.obs; // State untuk toggle pemasukan/pengeluaran
  var amount = ''.obs; // State untuk nominal
  var note = ''.obs; // State untuk catatan
  var selectedCategory = 'Food & Drink'.obs; // State untuk kategori

  // Fungsi untuk toggle pemasukan/pengeluaran
  void toggleIncome(bool income) {
    isIncome.value = income;
  }

  // Fungsi untuk mengupdate nominal
  void updateAmount(String value) {
    amount.value = value;
  }

  // Fungsi untuk mengupdate note
  void updateNote(String value) {
    note.value = value;
  }

  // Fungsi untuk memilih kategori
  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  // Simpan data ke database (contoh aksi)
  void saveRecord() {
    if (amount.value.isEmpty || note.value.isEmpty) {
      Get.snackbar(
        "Error",
        "Nominal dan catatan tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Simulasi menyimpan data
    print("Data Disimpan:");
    print("Jenis: ${isIncome.value ? "Pemasukan" : "Pengeluaran"}");
    print("Nominal: ${amount.value}");
    print("Catatan: ${note.value}");
    print("Kategori: ${selectedCategory.value}");

    // Tampilkan notifikasi berhasil
    Get.snackbar(
      "Berhasil",
      "Record berhasil disimpan!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Kembali ke halaman sebelumnya
    Get.back();
  }
}
