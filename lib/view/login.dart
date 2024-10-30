import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_flow/controllers/login_controller.dart';
import 'package:money_flow/controllers/registartion_comntroller.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    final registerController = Provider.of<RegistartionComntroller>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 354,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 235, 206, 120),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -65,
                    right: 22,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                      child: Container(
                        height: 370,
                        width: 350,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 53.0),
                          child: Icon(
                            Icons.account_balance_wallet,
                            size: 40,
                            color: Color.fromARGB(255, 235, 206, 120),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Welcome to',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 29,
                          ),
                        ),
                        Text(
                          'Money Flow',
                          style: TextStyle(
                            color: Color.fromARGB(255, 235, 206, 120),
                            fontSize: 29,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign in',
                  style: GoogleFonts.lato(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            } else {
                              return null;
                            }
                          },
                          controller: loginController.usernameController,
                          decoration: const InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            } else {
                              return null;
                            }
                          },
                          controller: loginController.passwordController,
                          obscureText: registerController.isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            suffix: IconButton(
                              onPressed: () {
                                registerController.togglePasswordVisibility();
                              },
                              icon: registerController.isPasswordVisible == true
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1.0),
                  Text(
                    registerController.errorMesssage,
                    style: const TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginController.login(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
