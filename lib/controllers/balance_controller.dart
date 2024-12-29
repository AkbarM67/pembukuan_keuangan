import 'package:get/get.dart';

class BalanceController extends GetxController {
  // Saldo total
  RxInt totalBalance = 0.obs;

  // Tambahkan pemasukan
  void addIncome(int amount) {
    totalBalance.value += amount;
  }

  // Kurangkan pengeluaran
  void addExpense(int amount) {
    totalBalance.value -= amount;
  }
}
