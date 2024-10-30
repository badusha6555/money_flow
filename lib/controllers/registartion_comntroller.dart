import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistartionComntroller extends ChangeNotifier {
  String errorMesssage = '';

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future signUp(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setBool('isLoggedIn', false);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Sign Up Successful!'),
    ));

    Navigator.pushReplacementNamed(context, '/bottom');
  }

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
}
