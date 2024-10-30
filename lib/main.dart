import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/controllers/add_budget_provider.dart';
import 'package:money_flow/controllers/add_provider.dart';
import 'package:money_flow/controllers/login_controller.dart';
import 'package:money_flow/controllers/pie_controller.dart';
import 'package:money_flow/controllers/registartion_comntroller.dart';
import 'package:money_flow/model/advisor/advisor.dart';
import 'package:money_flow/model/expense/expense.dart';
import 'package:money_flow/model/income/income.dart';
import 'package:money_flow/model/user/user.dart';
import 'package:money_flow/services/balance_service.dart';
import 'package:money_flow/services/budget_services.dart';
import 'package:money_flow/services/expense_services.dart';
import 'package:money_flow/services/income_services.dart';
import 'package:money_flow/services/pie_data_services.dart';
import 'package:money_flow/services/profile_servises.dart';
import 'package:money_flow/view/analysis.dart';
import 'package:money_flow/view/home_screen.dart';
import 'package:money_flow/view/login.dart';
import 'package:money_flow/view/splash.dart';
import 'package:money_flow/view/startscreen.dart';
import 'package:money_flow/view/widgets/addbudget.dart';
import 'package:money_flow/view/widgets/adddata.dart';
import 'package:money_flow/view/widgets/bottom.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(IncomeAdapter());
  Hive.registerAdapter(BudgetSetterAdapter());
  runApp(MyApp());
}

bool isLoggedIn = false;
User currentUser = User(name: "", age: "", phone: '', imagePath: "");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddProvider()),
        ChangeNotifierProvider(create: (context) => AddBudgetProvider()),
        ChangeNotifierProvider(create: (context) => IncomeServices()),
        ChangeNotifierProvider(create: (context) => ExpenseServices()),
        ChangeNotifierProvider(create: (context) => BudgetServices()),
        ChangeNotifierProvider(create: (context) => PieDataServices()),
        ChangeNotifierProvider(create: (context) => BalanceService()),
        ChangeNotifierProvider(create: (context) => PieController()),
        ChangeNotifierProvider(create: (context) => RegistartionComntroller()),
        ChangeNotifierProvider(
            create: (context) => ProfileProvider(currentUser)),
        ChangeNotifierProvider(create: (context) => LoginController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Money Flow',
        theme: ThemeData(primarySwatch: Colors.brown),
        home: SplashScreen(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => Homescreen(),
          '/analysis': (context) => analsys(),
          '/bottom': (context) => Bottombar(),
          '/start': (context) => Startscreen(),
          '/adddata': (context) => AddData(),
          '/addbudget': (context) => AddBudget(),
        },
      ),
    );
  }
}
