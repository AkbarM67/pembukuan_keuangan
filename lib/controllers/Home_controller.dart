import 'package:get/get.dart';

class HomeController extends GetxController {
  var transactions = <Map<String, dynamic>>[].obs;

  void addTransaction(Map<String, dynamic> transaction) {
    transactions.add(transaction);
  }
}
