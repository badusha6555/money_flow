import 'package:flutter/material.dart';
import 'package:money_flow/controllers/add_provider.dart';
import 'package:provider/provider.dart';

class AddData extends StatelessWidget {
  AddData({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var addProvider = Provider.of<AddProvider>(context, listen: false);

    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 235, 206, 120),
      title: const Text('Add Transaction'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Consumer<AddProvider>(
                  builder: (context, addProvider, child) => Checkbox(
                    value: addProvider.isIncome,
                    onChanged: (value) {
                      addProvider.setIncomeStatus(value ?? false);
                    },
                  ),
                ),
                const Text('Income'),
                Consumer<AddProvider>(
                  builder: (context, addProvider, child) => Checkbox(
                    value: addProvider.isExpense,
                    onChanged: (value) {
                      addProvider.setExpenseStatus(value ?? false);
                    },
                  ),
                ),
                const Text('Expense'),
              ],
            ),
            if (addProvider.isExpense)
              Row(
                children: [
                  Consumer<AddProvider>(
                    builder: (context, addProvider, child) => Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration:
                            const InputDecoration(labelText: 'Category'),
                        value: addProvider.selectedCategory.isEmpty
                            ? null
                            : addProvider.selectedCategory,
                        onChanged: (newValue) {
                          addProvider.selectedCategory = newValue ?? '';
                        },
                        items: addProvider.expenseCategories
                            .map((category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            if (addProvider.isIncome)
              Row(
                children: [
                  Consumer<AddProvider>(
                    builder: (context, addProvider, child) => Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration:
                            const InputDecoration(labelText: 'Category'),
                        value: addProvider.selectedCategory.isEmpty
                            ? null
                            : addProvider.selectedCategory,
                        onChanged: (newValue) {
                          addProvider.selectedCategory = newValue ?? '';
                        },
                        items: addProvider.incomeCategories
                            .map((category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the amount';
                      }

                      return null;
                    },
                    controller: addProvider.amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Amount',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a note';
                      }
                      return null;
                    },
                    controller: addProvider.noteController,
                    decoration: const InputDecoration(
                      labelText: 'Short Note',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              addProvider.onAddExpenseOrIncome(context);
              addProvider.clearControllers();
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
