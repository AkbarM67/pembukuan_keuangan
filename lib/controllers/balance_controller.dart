import 'package:get/get.dart';

class BalanceController extends GetxController {
  // Saldo total
  final RxInt _totalBalance = 0.obs; // Deklarasi RxInt

  int get totalBalance => _totalBalance.value;

  // Tambahkan pemasukan
  void addIncome(int amount) {
    _totalBalance.value += amount;
  }

  // Kurangkan pengeluaran
  void addExpense(int amount) {
    _totalBalance.value -= amount;
  }
}
