import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:money_flow/services/balance_service.dart';

import 'package:money_flow/view/widgets/advisorlist.dart';
import 'package:provider/provider.dart';

class Advisor extends StatelessWidget {
  Advisor({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBalance = Provider.of<BalanceService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Budget Setter',
          style: GoogleFonts.lato(
              color: Color.fromARGB(255, 235, 206, 120),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 40, 0),
                        child: Consumer(
                          builder: (context, snapshot, child) => Row(
                            children: [
                              FutureBuilder<int>(
                                future: homeBalance.totolExpence(),
                                builder: (context, snapshot) {
                                  return buildStatColumn(
                                      'Expense', '\$${snapshot.data}');
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(110, 0, 0, 0),
                                child: FutureBuilder<int>(
                                  future: homeBalance.totleIncome(),
                                  builder: (context, snapshot) {
                                    return buildStatColumn(
                                        'Income', '\$${snapshot.data}');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Added Categories :',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 450,
                    child: AdvisorList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addbudget');
          },
          backgroundColor: Color.fromARGB(255, 235, 206, 120),
          child: const Icon(Icons.add, color: Colors.black)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Column buildStatColumn(String title, String amount) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color.fromARGB(255, 235, 206, 120),
            fontSize: 16,
          ),
        ),
        SizedBox(height: 5),
        Text(
          amount,
          style: TextStyle(
            color: const Color.fromARGB(255, 235, 206, 120),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
