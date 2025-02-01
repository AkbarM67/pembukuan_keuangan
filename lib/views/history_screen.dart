import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pembukuan_keuangan/controllers/history_controller.dart';
import '../models/transaction_model.dart';

class HistoryScreen extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());

  HistoryScreen({Key? key}) : super(key: key);

  String formatCurrency(int value) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0);
    return formatter.format(value);
  }

  String formatMonth(String key) {
    final parts = key.split("-");
    final year = parts[0];
    final month = parts[1];
    final date = DateTime(int.parse(year), int.parse(month));
    return DateFormat.yMMM().format(date); // Contoh: "Mar 2021"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tab Pemasukan dan Pengeluaran
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () => controller.showIncome.value = false,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !controller.showIncome.value ? Colors.blue : Colors.grey[300],
                    ),
                    child: const Text("Pengeluaran"),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () => controller.showIncome.value = true,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.showIncome.value ? Colors.blue : Colors.grey[300],
                    ),
                    child: const Text("Pemasukan"),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Total Keuangan
          Obx(
            () {
              final isIncome = controller.showIncome.value;
              final total = controller.transactions
                  .where((t) => t.isIncome == isIncome)
                  .fold(0, (sum, t) => sum + t.nominal);

              return Text(
                formatCurrency(total),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Daftar Transaksi
          Expanded(
            child: Obx(() {
              final isIncome = controller.showIncome.value;
              final transactionsByMonth = controller.getTransactionsByMonth(isIncome);

              if (transactionsByMonth.isEmpty) {
                return const Center(child: Text("Belum ada transaksi"));
              }

              return ListView(
                children: transactionsByMonth.entries.map((entry) {
                  final month = formatMonth(entry.key);
                  final transactions = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          month,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...transactions.map((transaction) => ListTile(
                            leading: CircleAvatar(
                              child: Text(transaction.category[0]),
                            ),
                            title: Text(transaction.category),
                            subtitle: Text(transaction.note),
                            trailing: Text(
                              formatCurrency(transaction.nominal),
                              style: TextStyle(
                                color: transaction.isIncome ? Colors.green : Colors.red,
                              ),
                            ),
                          )),
                    ],
                  );
                }).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }
}
