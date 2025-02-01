import 'package:get/get.dart';

class AddRecordController extends GetxController {
  // Status pemasukan/pengeluaran
  final RxBool _isIncome = true.obs;
  bool get isIncome => _isIncome.value;

  // Nominal
  final RxString _amount = ''.obs;
  String get amount => _amount.value;

  // Note
  final RxString _note = ''.obs;
  String get note => _note.value;

  // Kategori
  final RxString _selectedCategory = 'Pilih Kategori'.obs;
  String get selectedCategory => _selectedCategory.value;

  // Toggle status pemasukan/pengeluaran
  void toggleIncome(bool value) {
    _isIncome.value = value;
  }

  // Update nominal
  void updateAmount(String value) {
    _amount.value = value;
  }

  // Update note
  void updateNote(String value) {
    _note.value = value;
  }

  // Update category
  void selectCategory(String category) {
    _selectedCategory.value = category;
  }

  
}
