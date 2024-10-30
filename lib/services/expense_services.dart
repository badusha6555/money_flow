import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/model/expense/expense.dart';

class ExpenseServices extends ChangeNotifier {
  List<Expense> listExpense = [];
  Future<void> addExpense(Expense expense) async {
    final expenseDb = await Hive.openBox<Expense>("expense_db");
    await expenseDb.add(expense);
    listExpense.add(expense);
    notifyListeners();
    log("Expense added: ${expense.amount}");
  }

  Future<void> deleteExpense(int index) async {
    final expenseDb = await Hive.openBox<Expense>("expense_db");
    expenseDb.deleteAt(index);
    notifyListeners();
    getAllExpenses();
  }

  Future<void> getAllExpenses() async {
    final expenseDb = await Hive.openBox<Expense>("expense_db");
    listExpense.clear();
    listExpense.addAll(expenseDb.values);
    notifyListeners();
  }
}
