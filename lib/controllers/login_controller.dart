import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  String errorMesssage = '';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future login(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (savedUsername == usernameController.text &&
        savedPassword == passwordController.text) {
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacementNamed(context, '/bottom');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Invalid Username or Password",
        style: TextStyle(color: Colors.red),
      )));
    }
  }
}
