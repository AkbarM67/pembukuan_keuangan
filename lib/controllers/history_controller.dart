import 'package:get/get.dart';
import '../models/transaction_model.dart';

class HistoryController extends GetxController {
  // Semua transaksi
  var transactions = <TransactionModel>[].obs;

  // Filter berdasarkan pemasukan atau pengeluaran
  var showIncome = true.obs;

  // Tambahkan transaksi baru
  void addTransaction(TransactionModel transaction) {
    transactions.add(transaction);
  }

  // Filter transaksi berdasarkan bulan dan tahun
  Map<String, List<TransactionModel>> getTransactionsByMonth(bool isIncome) {
    final filtered = transactions.where((t) => t.isIncome == isIncome).toList();

    // Grouping berdasarkan bulan dan tahun
    final grouped = <String, List<TransactionModel>>{};
    for (var transaction in filtered) {
      final key = "${transaction.date.year}-${transaction.date.month}";
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(transaction);
    }

    return grouped;
  }
}
