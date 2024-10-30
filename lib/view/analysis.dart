import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_flow/controllers/pie_controller.dart';
import 'package:money_flow/view/widgets/buildlist.dart';
import 'package:provider/provider.dart';

class analsys extends StatelessWidget {
  const analsys({super.key});

  @override
  Widget build(BuildContext context) {
    final pieController = Provider.of<PieController>(context);
    Provider.of<PieController>(context, listen: false)
        .getPieTotal(pieController.selectedDate, context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 235, 206, 120),
        title: Text(
          "Analysis",
          style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 235, 206, 120),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.arrow_left,
                      color: Color.fromARGB(255, 235, 206, 120),
                    ),
                    onPressed: () {
                      pieController.changeMonth(-1, context);
                    }),
                Text(
                  "${pieController.getMonthName(pieController.selectedDate.month)}, ${pieController.selectedDate.year}",
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 235, 206, 120),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.arrow_right,
                        color: Color.fromARGB(255, 235, 206, 120)),
                    onPressed: () {
                      pieController.changeMonth(1, context);
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Earning  Analysis",
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                pieController.isDataAvailable
                    ? SizedBox(
                        height: 200,
                        child: PieChart(
                          swapAnimationCurve: Curves.easeOutQuint,
                          swapAnimationDuration:
                              const Duration(milliseconds: 300),
                          PieChartData(
                            sections: [
                              for (var i = 0;
                                  i < pieController.dataMap.length;
                                  i++)
                                PieChartSectionData(
                                  color: pieController.colorList[i],
                                  value:
                                      pieController.dataMap.values.toList()[i],
                                  radius: 50.0,
                                  titleStyle: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          'No Data Available',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recent Expenses",
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      SizedBox(
                        height: 300,
                        child: ExpenseList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
