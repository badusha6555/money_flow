import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/model/expense/expense.dart';
import 'package:money_flow/model/income/income.dart';

class BalanceService extends ChangeNotifier {
  Future<int> calculateBalance() async {
    final totalIncome = await totleIncome();
    final totalExpense = await totolExpence();
    return totalIncome - totalExpense;
  }

  Future<int> totleIncome() async {
    final incomeDb = await Hive.openBox<Income>("income_db");

    var exp = 0;
    for (var i = 0; i < incomeDb.length; i++) {
      exp += incomeDb.values.toList()[i].amount!;
    }
    notifyListeners();

    return exp;
  }

  Future<int> totolExpence() async {
    final expenseDb = await Hive.openBox<Expense>("expense_db");
    var exp = 0;
    for (var i = 0; i < expenseDb.length; i++) {
      exp += expenseDb.values.toList()[i].amount!;
    }
    notifyListeners();

    return exp;
  }

  String getTotalIncome() {
    return totleIncome().toString();
  }

  String getTotalExpense() {
    return totolExpence().toString();
  }

  String getBalance() {
    return calculateBalance().toString();
  }
}
