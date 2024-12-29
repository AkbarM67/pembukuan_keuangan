import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pembukuan_keuangan/controllers/add_record_controller.dart';

class AddRecordScreen extends StatelessWidget {
  final AddRecordController controller = Get.put(AddRecordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Add Record',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Toggle Pemasukan / Pengeluaran
          Container(
            color: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleButton(
                    label: 'Pengeluaran',
                    isSelected: !controller.isIncome,
                    onTap: () => controller.toggleIncome(false),
                  ),
                  const SizedBox(width: 8),
                  _buildToggleButton(
                    label: 'Pemasukan',
                    isSelected: controller.isIncome,
                    onTap: () => controller.toggleIncome(true),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Form Input
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nominal Input Field
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.account_balance_wallet, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "IDR ${controller.amount}",
                              style: const TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.grey),
                            onPressed: () => controller.updateAmount(''),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Note Field
                  TextField(
                    onChanged: (value) => controller.updateNote(value),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.edit),
                      hintText: "Note",
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Category Selector
                  GestureDetector(
                    onTap: () {
                      controller.selectCategory("Food & Drink");
                    },
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.grid_view, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text(
                                  controller.selectedCategory,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Keypad
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        if (index == 9) {
                          // Biometric or Fingerprint Button
                          return IconButton(
                            icon: const Icon(Icons.fingerprint, color: Colors.deepPurple),
                            onPressed: () {},
                          );
                        } else if (index == 10) {
                          return _buildKeypadButton(
                            label: '0',
                            onTap: () => controller.updateAmount(controller.amount + '0'),
                          );
                        } else if (index == 11) {
                          // Backspace Button
                          return IconButton(
                            icon: const Icon(Icons.backspace, color: Colors.deepPurple),
                            onPressed: () {
                              if (controller.amount.isNotEmpty) {
                                controller.updateAmount(
                                  controller.amount.substring(0, controller.amount.length - 1),
                                );
                              }
                            },
                          );
                        } else {
                          // Number Buttons (1 to 9)
                          return _buildKeypadButton(
                            label: '${index + 1}',
                            onTap: () => controller.updateAmount(controller.amount + '${index + 1}'),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Submit Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validasi Input
                if (controller.amount.isEmpty || int.tryParse(controller.amount) == null) {
                  Get.snackbar(
                    "Error",
                    "Masukkan nominal yang valid!",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }

                // Data transaksi
                final transaction = {
                  'nominal': int.parse(controller.amount),
                  'note': controller.note,
                  'category': controller.selectedCategory,
                  'isIncome': controller.isIncome,
                };

                print("Mengirim data transaksi: $transaction"); // Debug log

                // Kirim data ke HomeScreen
                Get.back(result: transaction);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.deepPurple,
              ),
              child: const Center(
                child: Text(
                  "Send",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Toggle Button Builder
  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.deepPurple,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.deepPurple : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Keypad Button Builder
  Widget _buildKeypadButton({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
