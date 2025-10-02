import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, String, DateTime)? addTransaction;

  const TransactionForm({super.key, @required this.addTransaction});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _selectedDate;
  String? _errorTitleText;
  String? _errorPriceText;

  void _submitForm(BuildContext context) {
    _errorTitleText = _titleController.text.isEmpty
        ? "Title must have a value"
        : null;

    _errorPriceText = _priceController.text.isEmpty
        ? "You must enter a value"
        : null;

    if (_titleController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _selectedDate == null) {
      return;
    }
    Navigator.of(context).pop();

    widget.addTransaction!(
      _titleController.text,
      _priceController.text,
      _selectedDate!,
    );

    _titleController.text = "";
    _priceController.text = "";
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          right: 16,
          left: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            TextField(
              decoration: InputDecoration(
                labelText: "Expense Name",
                errorText: _errorTitleText,
              ),
              controller: _titleController,
            ),

            // Amount
            TextField(
              decoration: InputDecoration(
                labelText: "Amount Spent",
                errorText: _errorPriceText,
              ),
              keyboardType: TextInputType.number,
              controller: _priceController,
            ),

            // Date Picker
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "No Date Chosen"
                          : "Picked Date: ${DateFormat.yMd().format(_selectedDate!)}",
                    ),
                  ),

                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: Icon(Icons.calendar_month),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
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
                  onPressed: () => _submitForm(context),
                  child: Text(
                    "Add",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
