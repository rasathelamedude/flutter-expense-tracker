import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final dateController = TextEditingController();
  String? errorTitleText;
  String? errorPriceText;

  final void Function(String, String)? addTransaction;

  TransactionForm({super.key, @required this.addTransaction});

  void submitForm(BuildContext context) {
    errorTitleText = titleController.text.isEmpty
        ? "Title must have a value"
        : null;

    errorPriceText = priceController.text.isEmpty
        ? "You must enter a value"
        : null;

    if (titleController.text.isNotEmpty && priceController.text.isNotEmpty) {
      Navigator.of(context).pop();

      addTransaction!(titleController.text, priceController.text);

      titleController.text = "";
      priceController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 16,
          left: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text Fields
            TextField(
              decoration: InputDecoration(
                labelText: "Expense Name",
                errorText: errorTitleText,
              ),
              controller: titleController,
            ),
            // TextField(
            //   decoration: InputDecoration(labelText: "Expense Date"),
            //   keyboardType: TextInputType.datetime,
            //   controller: dateController,
            // ),
            TextField(
              decoration: InputDecoration(
                labelText: "Amount Spent",
                errorText: errorPriceText,
              ),
              keyboardType: TextInputType.number,
              controller: priceController,
            ),

            // Space
            const SizedBox(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () => submitForm(context),
                  child: Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
