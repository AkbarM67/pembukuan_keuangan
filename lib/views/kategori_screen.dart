import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pembukuan_keuangan/controllers/kategori_controller.dart'; // Import controller

class CategorySelectionScreen extends StatelessWidget {
  final CategoryController categoryController = Get.find<CategoryController>();

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.receipt, 'name': 'Bills', 'color': Colors.blue},
    {'icon': Icons.money, 'name': 'Cash', 'color': Colors.green},
    {'icon': Icons.movie, 'name': 'Entertainment', 'color': Colors.purple},
    {'icon': Icons.family_restroom, 'name': 'Family', 'color': Colors.yellow},
    {'icon': Icons.fastfood, 'name': 'Eating out', 'color': Colors.orange},
    {'icon': Icons.wallet, 'name': 'Expenses', 'color': Colors.cyan},
    {'icon': Icons.show_chart, 'name': 'Investment', 'color': Colors.green},
    {'icon': Icons.home, 'name': 'Housing', 'color': Colors.amber},
    {'icon': Icons.category, 'name': 'General', 'color': Colors.teal},
    {'icon': Icons.shopping_cart, 'name': 'Groceries', 'color': Colors.pink},
    {'icon': Icons.shopping_bag, 'name': 'Shopping', 'color': Colors.purple},
    {'icon': Icons.savings, 'name': 'Savings', 'color': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a category"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Obx(() => ListTile(
                leading: CircleAvatar(
                  backgroundColor: category['color'],
                  child: Icon(
                    category['icon'],
                    color: Colors.white,
                  ),
                ),
                title: Text(category['name']),
                trailing: Radio<String>(
                  value: category['name'],
                  groupValue: categoryController.selectedCategory.value,
                  onChanged: (value) {
                    categoryController.setCategory(value!);
                  },
                ),
                onTap: () {
                  categoryController.setCategory(category['name']);
                },
              ));
        },
      ),
    );
  }
}
