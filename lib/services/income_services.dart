import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/model/income/income.dart';

class IncomeServices extends ChangeNotifier {
  List<Income> listIncome = [];

  Future<void> addIncome(Income income) async {
    final incomeDb = await Hive.openBox<Income>("income_db");
    await incomeDb.add(income);
    listIncome.add(income);
    notifyListeners();
    log("Income added: ${income.amount}");
  }

  Future<void> deleteIncome(int index) async {
    final incomeDb = await Hive.openBox<Income>("income_db");
    incomeDb.deleteAt(index);
    notifyListeners();
  }

  Future<void> getAllIncomes() async {
    final incomeDb = await Hive.openBox<Income>("income_db");
    listIncome.clear();
    listIncome.addAll(incomeDb.values);
    notifyListeners();
  }
}
