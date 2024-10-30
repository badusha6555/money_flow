import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:money_flow/controllers/add_provider.dart';
import 'package:money_flow/services/expense_services.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ExpenseServices>(context, listen: false).getAllExpenses();
    final listOfExpense = Provider.of<ExpenseServices>(context).listExpense;
    if (listOfExpense.isEmpty) {
      return Center(
        child: Text(
          'No Expense Found',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<ExpenseServices>(
          builder: (context, value, child) => ListView.separated(
            itemBuilder: (context, index) {
              final data = value.listExpense[index];
              String formattedDate =
                  DateFormat('dd MMM yyyy').format(data.date ?? DateTime.now());
              listOfExpense.sort((a, b) => b.date!.compareTo(a.date!));
              return ListTile(
                title: Text(
                  '₹${data.amount ?? '0.00'}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.category ?? 'No Category'),
                    Text(formattedDate),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    Provider.of<ExpenseServices>(context, listen: false)
                        .deleteExpense(index);
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
                thickness: 1,
              );
            },
            itemCount: listOfExpense.length,
          ),
        ),
      ),
    );
  }
}
