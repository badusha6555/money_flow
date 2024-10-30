import 'package:flutter/material.dart';
import 'package:money_flow/model/expense/expense.dart';
import 'package:money_flow/model/income/income.dart';
import 'package:money_flow/services/balance_service.dart';
import 'package:money_flow/services/budget_services.dart';
import 'package:money_flow/services/expense_services.dart';
import 'package:money_flow/services/income_services.dart';
import 'package:provider/provider.dart';

class AddProvider extends ChangeNotifier {
  List<String> incomeCategories = [
    'Salary',
    'Bonus',
    'Investment',
    'Gift',
    'Other',
  ];
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

  bool isIncome = false;
  bool isExpense = false;
  String selectedCategory = '';
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController newCategoryController = TextEditingController();

  void clearControllers() {
    amountController.clear();
    noteController.clear();
    newCategoryController.clear();
  }

  Future<void> onAddExpenseOrIncome(BuildContext context) async {
    String amount = amountController.text.trim();
    String note = noteController.text.trim();
    String category = selectedCategory;

    if (amount.isEmpty || note.isEmpty || category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (isExpense) {
      final expense = Expense(
        isExpense: true,
        category: category,
        amount: int.tryParse(amount),
        description: note,
        date: DateTime.now(),
      );
      Provider.of<ExpenseServices>(context, listen: false).addExpense(expense);
      Provider.of<BudgetServices>(context, listen: false)
          .subtractFromBudget(category, int.parse(amount));
      Provider.of<BalanceService>(context, listen: false).totolExpence();
    } else {
      final income = Income(
        isIncome: true,
        category: category,
        description: note,
        date: DateTime.now(),
        amount: int.tryParse(amount),
      );
      Provider.of<IncomeServices>(context, listen: false).addIncome(income);
      Provider.of<BalanceService>(context, listen: false).totleIncome();
    }
    clearControllers();
  }

  void setIncomeStatus(bool value) {
    isIncome = value;
    if (isIncome) {
      isExpense = false;
      selectedCategory = '';
    }
    notifyListeners();
  }

  void setExpenseStatus(bool value) {
    isExpense = value;
    if (isExpense) {
      // isExpense = true;
      isIncome = false;
      selectedCategory = '';
    }
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }
}
