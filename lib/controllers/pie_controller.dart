import 'package:flutter/material.dart';
import 'package:money_flow/services/pie_data_services.dart';
import 'package:provider/provider.dart';

class PieController extends ChangeNotifier {
  final colorList = <Color>[
    const Color.fromARGB(255, 235, 206, 120),
    const Color.fromARGB(255, 255, 0, 0),
  ];
  DateTime selectedDate = DateTime.now();

  void changeMonth(int increment, context) {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + increment);
    getPieTotal(selectedDate, context);
    notifyListeners();
  }

  double incomeTotal = 0.0;
  double expenseTotal = 0.0;
  Map<String, double> dataMap = {};
  bool isDataAvailable = false;

  Future<void> getPieTotal(DateTime selectedDate, context) async {
    double income = await pieIncome(selectedDate, context);
    double expense = await pieExpenses(selectedDate, context);

    incomeTotal = income;
    expenseTotal = expense;

    if (incomeTotal == 0 && expenseTotal == 0) {
      dataMap = {};
      isDataAvailable = false;
    } else {
      isDataAvailable = true;
      dataMap = {
        "Total Income": incomeTotal,
        "Total Expense": expenseTotal,
      };
    }
    notifyListeners();
  }

  String getMonthName(int month) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return monthNames[month - 1];
  }

  Future<dynamic> pieIncome(DateTime date, context) async {
    return Provider.of<PieDataServices>(context, listen: false).pieIncome(date);
  }

  Future<dynamic> pieExpenses(DateTime date, context) async {
    return Provider.of<PieDataServices>(context, listen: false)
        .pieExpenses(date);
  }
}
