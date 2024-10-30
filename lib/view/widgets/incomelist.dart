import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/services/income_services.dart';
import 'package:provider/provider.dart';

class Incomelist extends StatelessWidget {
  const Incomelist({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<IncomeServices>(context, listen: false).getAllIncomes();
    final listOfIncome = Provider.of<IncomeServices>(context).listIncome;
    if (listOfIncome.isEmpty) {
      return Center(
        child: Text(
          'No Income Found',
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
        child: Consumer<IncomeServices>(
          builder: (context, value, child) => ListView.separated(
            itemBuilder: (context, index) {
              final data = value.listIncome[index];
              String formattedDate =
                  DateFormat('dd MMM yyyy').format(data.date ?? DateTime.now());
              listOfIncome.sort((a, b) => b.date!.compareTo(a.date!));
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
                    Provider.of<IncomeServices>(context, listen: false)
                        .deleteIncome(index);
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
            itemCount: listOfIncome.length,
          ),
        ),
      ),
    );
  }
}
