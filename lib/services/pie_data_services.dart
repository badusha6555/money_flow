import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/model/advisor/advisor.dart';
import 'package:money_flow/model/expense/expense.dart';
import 'package:money_flow/model/income/income.dart';

class PieDataServices extends ChangeNotifier {
  pieIncome(DateTime selectedDate) async {
    final incomeDb = await Hive.openBox<Income>("income_db");
    return incomeDb.values.fold(0.0, (sum, item) => sum + item.amount!);
  }

  pieExpenses(DateTime selectedDate) async {
    final expenseDb = await Hive.openBox<Expense>("expense_db");
    return expenseDb.values.fold(0.0, (sum, item) => sum + item.amount!);
  }

  void resetData() async {
    final expenseDb = await Hive.openBox<Expense>("expense_db");
    final incomeDb = await Hive.openBox<Income>("income_db");
    final budgetDb = await Hive.openBox<BudgetSetter>("budget_db");
    expenseDb.clear();
    incomeDb.clear();
    budgetDb.clear();
  }
}
