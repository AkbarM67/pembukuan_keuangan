import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pembukuan_keuangan/controllers/add_record_controller.dart';

class AddRecordScreen extends StatelessWidget {
  final AddRecordController controller = Get.put(AddRecordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Record'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Toggle Pemasukan/Pengeluaran
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildToggleButton("Pengeluaran", !controller.isIncome.value),
                    _buildToggleButton("Pemasukan", controller.isIncome.value),
                  ],
                )),
            SizedBox(height: 16),

            // Input Nominal
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.updateAmount(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.attach_money),
                hintText: "Nominal",
                fillColor: Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Note Field
            TextField(
              onChanged: (value) => controller.updateNote(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.edit),
                hintText: "Note",
                fillColor: Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Kategori
            GestureDetector(
              onTap: () {
                // Contoh: ubah kategori secara manual
                controller.selectCategory("Shopping");
              },
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.category, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            controller.selectedCategory.value,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                    ],
                  )),
            ),
            Divider(),

            Spacer(),

            // Tombol Kirim
            ElevatedButton(
              onPressed: () => controller.saveRecord(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.blue,
              ),
              child: Center(
                child: Text(
                  "Send",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isActive) {
    return GestureDetector(
      onTap: () {
        controller.toggleIncome(text == "Pemasukan");
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? Colors.blue : Colors.grey[200],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
