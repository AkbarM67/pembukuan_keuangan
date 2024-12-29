import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pembukuan_keuangan/controllers/balance_controller.dart';
import 'package:pembukuan_keuangan/views/add_record_screen.dart';

class HomeController extends GetxController {
  var userName = ''.obs; // Nama pengguna
  var transactions = <Map<String, dynamic>>[].obs; // Daftar transaksi

  // Simulasi mengambil nama pengguna
  void fetchUserName(String name) {
    userName.value = name;
  }

  // Tambahkan transaksi baru
  void addTransaction(Map<String, dynamic> transaction) {
    transactions.add(transaction);
  }
}

class HomeScreen extends StatelessWidget {
  final BalanceController balanceController = Get.put(BalanceController());
  final HomeController controller = Get.put(HomeController());

  void navigateToAddRecord() async {
    final result = await Get.to(() => AddRecordScreen());

    if (result != null && result is Map<String, dynamic>) {
      // Ambil data dari result
      final int nominal = result['nominal'] ?? 0;
      final String note = result['note'] ?? '';
      final String category = result['category'] ?? '';
      final bool isIncome = result['isIncome'] ?? true;

      // Perbarui saldo berdasarkan pemasukan/pengeluaran
      if (isIncome) {
        balanceController.addIncome(nominal);
      } else {
        balanceController.addExpense(nominal);
      }

      // Tambahkan data transaksi ke daftar
      controller.addTransaction({
        'nominal': nominal,
        'note': note,
        'category': category,
        'isIncome': isIncome,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Latar belakang utama
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
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
                        // Greeting dan Saldo
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                "Halo, ${controller.userName.value}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(
                              () => Text(
                                "IDR ${balanceController.totalBalance.value}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Foto Profil
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            'assets/images/profile.png',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Tombol Aksi Cepat
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
              ),
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
                            final isIncome = transaction['isIncome'] ?? true;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: Icon(
                                  isIncome ? Icons.arrow_circle_up : Icons.arrow_circle_down,
                                  color: isIncome ? Colors.green : Colors.red,
                                ),
                                title: Text(
                                  "IDR ${transaction['nominal']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(transaction['note']),
                                trailing: Text(
                                  transaction['category'],
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
}
