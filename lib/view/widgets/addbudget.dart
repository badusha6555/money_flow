import 'package:flutter/material.dart';
import 'package:money_flow/controllers/add_budget_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddBudget extends StatelessWidget {
  AddBudget({super.key});

  final _formKey = GlobalKey<FormState>();

  List<String> expenseCategories = [
    'Groceries',
    'Rent',
    'Utilities',
    'Transportation',
    'Entertainment',
    'Healthcare',
    'Education',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    final budgetProvider =
        Provider.of<AddBudgetProvider>(context, listen: false);
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 235, 206, 120),
      title: Text('Set Budget for Category'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Category'),
                    value: budgetProvider.selectedCategory.isEmpty
                        ? null
                        : budgetProvider.selectedCategory,
                    onChanged: (newValue) {
                      budgetProvider.selectedCategory = newValue!;
                    },
                    items: expenseCategories
                        .map((category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount';
                  }

                  return null;
                },
                controller: budgetProvider.amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Budget Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() == true) {
              budgetProvider.onAddBudget(context);
              budgetProvider.clearControllers();
              Navigator.pop(context);
            }
          },
          child: Text('Set Budget'),
        ),
      ],
    );
  }
}
