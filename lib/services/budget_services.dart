import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/model/advisor/advisor.dart';

class BudgetServices extends ChangeNotifier {
  List<BudgetSetter> listBudget = [];
  Future<bool> subtractFromBudget(String category, int amount) async {
    final budgetBox = await Hive.openBox<BudgetSetter>('budgetBox');

    final budgetDb = budgetBox.values.toList().firstWhere(
          (b) => b.category == category,
        );

    if (int.tryParse(budgetDb.amount!)! >= amount) {
      budgetDb.amount = (int.parse(budgetDb.amount!) - amount).toString();
      await updateBudget(budgetDb);
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateBudget(BudgetSetter budget) async {
    final budgetBox = await Hive.openBox<BudgetSetter>('budgetBox');

    int index = budgetBox.values
        .toList()
        .indexWhere((b) => b.category == budget.category);

    if (index != -1) {
      await budgetBox.putAt(index, budget);
    } else {
      await budgetBox.add(budget);
    }

    getAllBudgets();
  }

  Future<void> saveBudgetUpdates() async {
    final budgetBox = await Hive.openBox<BudgetSetter>('budgetBox');
    final budgetListCopy = List<BudgetSetter>.from(listBudget);
    for (var budget in budgetListCopy) {
      int index = budgetBox.values
          .toList()
          .indexWhere((b) => b.category == budget.category);

      if (index != -1) {
        await budgetBox.putAt(index, budget);
      } else {
        await budgetBox.add(budget);
      }
    }
  }

  Future<void> addBudget(BudgetSetter value) async {
    final budgetDb = await Hive.openBox<BudgetSetter>("budget_db");
    await budgetDb.add(value);
    listBudget.add(value);
    notifyListeners();
    log("Budget added : ${value.amount}");
  }

  Future<void> deleteBudget(int index) async {
    final budgetDb = await Hive.openBox<BudgetSetter>("budget_db");
    budgetDb.deleteAt(index);
    notifyListeners();
    getAllBudgets();
  }

  Future<void> getAllBudgets() async {
    final budgetDb = await Hive.openBox<BudgetSetter>("budget_db");
    listBudget.clear();
    listBudget.addAll(budgetDb.values);
    notifyListeners();
  }
}
