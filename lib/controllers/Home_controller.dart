import 'package:get/get.dart';
import 'package:pembukuan_keuangan/views/history_screen.dart';
import '../models/transaction_model.dart';

class HomeController extends GetxController {
  var transactions = <TransactionModel>[].obs; // List transaksi
  var userName = 'User'.obs; // Nama user (observable)
  var selectedIndex = 0.obs; // Indeks tab yang dipilih (observable)

  // Menambahkan transaksi ke dalam daftar
  void addTransaction(TransactionModel transaction) {
    transactions.add(transaction);
    print("Transaction added: $transaction");
    update(); // Memperbarui UI
  }

  // Mengubah tab indeks dan navigasi
  void changeTabIndex(int index) {
    selectedIndex.value = index; // Ubah nilai indeks
    // Navigasi berdasarkan indeks
    if (index == 0) {
      // Tetap di Home
    } else if (index == 1) {
      Get.to(() => HistoryScreen());
    } else if (index == 2) {
      print("Navigasi ke Cards");
      // Tambahkan navigasi ke CardsScreen
    } else if (index == 3) {
      print("Navigasi ke Account");
      // Tambahkan navigasi ke AccountScreen
    }
  }

  // Mengubah nama pengguna
  void setUserName(String name) {
    userName.value = name; // Ubah nama pengguna
  }
}
