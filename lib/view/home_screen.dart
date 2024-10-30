import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_flow/services/balance_service.dart';
import 'package:money_flow/view/widgets/adddata.dart';
import 'package:money_flow/view/widgets/buildlist.dart';
import 'package:money_flow/view/widgets/drawer.dart';
import 'package:money_flow/view/widgets/incomelist.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key, a});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    log("User logged out");

    Navigator.pushReplacementNamed(context, '/start');
  }

  @override
  Widget build(BuildContext context) {
    final homeBalance = Provider.of<BalanceService>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));
        },
        child: const Icon(Icons.add, color: Color.fromARGB(255, 235, 206, 120)),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Money Flow',
          style: GoogleFonts.lato(
            fontSize: 20,
            color: const Color.fromARGB(255, 235, 206, 120),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          Icons.wallet,
          color: Color.fromARGB(255, 235, 206, 120),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Color.fromARGB(255, 235, 206, 120),
            ),
            onPressed: () {
              _logOut();
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Consumer(
                    builder: (context, snapshot, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FutureBuilder<int>(
                          future: homeBalance.totolExpence(),
                          builder: (context, snapshot) {
                            return buildStatColumn(
                                'Expense', '\$${snapshot.data}');
                          },
                        ),
                        FutureBuilder<int>(
                            future: homeBalance.totleIncome(),
                            builder: (context, snapshot) {
                              return buildStatColumn(
                                  'Income', '\$${snapshot.data}');
                            }),
                        FutureBuilder<int>(
                          future: homeBalance.calculateBalance(),
                          builder: (context, snapshot) {
                            return buildStatColumn(
                                'Balance', '\$${snapshot.data}');
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelColor: const Color.fromARGB(255, 235, 206, 120),
                  unselectedLabelColor: Colors.black,
                  indicatorColor: const Color.fromARGB(255, 235, 206, 120),
                  tabs: const [
                    Tab(text: 'Expense '),
                    Tab(text: 'Income'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [ExpenseList(), Incomelist()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
