import 'package:flutter/material.dart';
import 'package:money_flow/services/budget_services.dart';
import 'package:provider/provider.dart';

class AdvisorList extends StatelessWidget {
  const AdvisorList({super.key});

  @override
  Widget build(BuildContext context) {
    final listOfBudget = Provider.of<BudgetServices>(context).listBudget;
    final budget = Provider.of<BudgetServices>(context);
    budget.getAllBudgets();

    budget.saveBudgetUpdates();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final data = listOfBudget[index];
              if (listOfBudget.isEmpty) {
                return Center(
                  child: Text(
                    'No Budget available',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                );
              } else {
                return Card(
                  color: Color.fromARGB(255, 235, 206, 120),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<BudgetServices>(
                          builder: (context, snapshot, child) => Text(
                            'Remaining: ${data.amount}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Consumer<BudgetServices>(
                          builder: (context, snapshot, child) => Text(
                            data.category ?? 'No Category',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 20, 19, 19),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                budget.deleteBudget(index);
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
                thickness: 1,
              );
            },
            itemCount: listOfBudget.length,
          ),
        ));
  }
}
