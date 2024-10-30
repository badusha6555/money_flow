import 'package:flutter/material.dart';
import 'package:money_flow/model/advisor/advisor.dart';
import 'package:money_flow/services/budget_services.dart';
import 'package:provider/provider.dart';

class AddBudgetProvider extends ChangeNotifier {
  String selectedCategory = '';
  TextEditingController amountController = TextEditingController();

  void clearControllers() {
    amountController.clear();
  }

  Future<void> onAddBudget(context) async {
    String amount = amountController.text;
    String category = selectedCategory;
    if (amount.isEmpty || category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Please fill all fields",
        style: TextStyle(color: Colors.red),
      )));
    }
    final adv = BudgetSetter(category: category, amount: amount);
    Provider.of<BudgetServices>(context, listen: false).addBudget(adv);
  }
}
