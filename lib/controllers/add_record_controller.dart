import 'package:get/get.dart';

class AddRecordController extends GetxController {
  // Mengelola apakah pemasukan atau pengeluaran
  RxBool _isIncome = true.obs;
  bool get isIncome => _isIncome.value;

  // Mengelola nominal
  RxString _amount = ''.obs;
  String get amount => _amount.value;

  // Mengelola note (catatan)
  RxString _note = ''.obs;
  String get note => _note.value;

  // Mengelola kategori
  RxString _selectedCategory = 'Pilih Kategori'.obs;
  String get selectedCategory => _selectedCategory.value;

  // Metode untuk memperbarui pemasukan/pengeluaran
  void toggleIncome(bool value) {
    _isIncome.value = value;
  }

  // Metode untuk memperbarui nominal
  void updateAmount(String value) {
    _amount.value = value;
  }

  // Metode untuk memperbarui note
  void updateNote(String value) {
    _note.value = value;
  }

  // Metode untuk memilih kategori
  void selectCategory(String category) {
    _selectedCategory.value = category;
  }

  // Simpan record ke database (simulasi)
  void saveRecord({required int nominal, required String note, required String category}) {
    print("Data yang disimpan:");
    print("Nominal: $nominal");
    print("Catatan: $note");
    print("Kategori: $category");
    print("Tipe: ${isIncome ? "Pemasukan" : "Pengeluaran"}");

    // TODO: Tambahkan logika untuk menyimpan ke database di sini
  }
}
