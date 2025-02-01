import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categories = [
    "Bills",
    "Cash",
    "Entertainment",
    "Family",
    "Eating out",
    "Expenses",
    "Investment",
    "Housing",
    "General",
    "Groceries",
    "Shopping",
    "Savings"
  ].obs;

  var selectedCategory = ''.obs;

  void setCategory(String category) {
    selectedCategory.value = category;
    print("Selected Category: $category");
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }
}
