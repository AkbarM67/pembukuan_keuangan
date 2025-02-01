import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pembukuan_keuangan/controllers/balance_controller.dart';
import 'package:pembukuan_keuangan/controllers/home_controller.dart';
import 'package:pembukuan_keuangan/models/transaction_model.dart';
import 'package:pembukuan_keuangan/views/add_record_screen.dart';
import 'package:pembukuan_keuangan/views/history_screen.dart';

class HomeScreen extends StatelessWidget {
  final BalanceController balanceController = Get.put(BalanceController());
  final HomeController controller = Get.put(HomeController());

  HomeScreen({Key? key}) : super(key: key);

  // Format mata uang
  String currencyFormat(int value) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0);
    return formatter.format(value);
  }

  void navigateToAddRecord() async {
    final result = await Get.to(() => AddRecordScreen());

    // Debugging
    print("Result dari AddRecordScreen: $result");

    if (result != null) {
      if (result is Map<String, dynamic>) {
        // Buat TransactionModel dari result
        final transaction = TransactionModel(
          nominal: result['nominal'] ?? 0,
          note: result['note'] ?? '',
          category: result['category'] ?? '',
          isIncome: result['isIncome'] ?? true,
          date: result['date'] ?? DateTime.now(), // Ambil dari result, atau default ke DateTime.now()
        );

        // Debugging
        print("TransactionModel berhasil dibuat: ${transaction.toMap()}");

        // Update saldo dan daftar transaksi
        if (transaction.isIncome) {
          balanceController.addIncome(transaction.nominal);
        } else {
          balanceController.addExpense(transaction.nominal);
        }
        controller.addTransaction(transaction);
      } else {
        print("Result bukan format yang valid untuk TransactionModel.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(),
              const SizedBox(height: 24),

              // Daftar Transaksi
              Expanded(
                child: Obx(
                  () => controller.transactions.isEmpty
                      ? const Center(child: Text("Belum ada transaksi"))
                      : ListView.builder(
                          itemCount: controller.transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = controller.transactions[index];
                            return _buildTransactionTile(transaction);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Header
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        "Halo, ${controller.userName.value}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                        currencyFormat(balanceController.totalBalance),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _quickActionButton("Add", Icons.add, onTap: navigateToAddRecord),
              _quickActionButton("Stats", Icons.bar_chart),
              _quickActionButton("Report", Icons.swap_horiz),
              _quickActionButton("Goals", Icons.flag),
            ],
          ),
        ],
      ),
    );
  }

  // Tombol Aksi Cepat
  Widget _quickActionButton(String label, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Tile Transaksi
  Widget _buildTransactionTile(TransactionModel transaction) {
    return ListTile(
      leading: Icon(
        transaction.isIncome ? Icons.arrow_circle_up : Icons.arrow_circle_down,
        color: transaction.isIncome ? Colors.green : Colors.red,
      ),
      title: Text(
        transaction.category,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(transaction.note),
      trailing: Text(
        currencyFormat(transaction.nominal),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: transaction.isIncome ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  // Bottom Navigation Bar
Widget _buildBottomNavigationBar() {
  return Obx(
    () => BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
      onTap: (index) => controller.changeTabIndex(index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Cards"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    ),
  );
}
}